using System;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Security.Cryptography;
using System.Text;

namespace InstaKG
{
    public partial class Steg_Encode : System.Web.UI.Page
    {
        private static byte[] _salt = Encoding.ASCII.GetBytes("jasdh7834y8hfeur73rsharks214");
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string fileExtension = System.IO.Path.GetExtension(fu_Image.FileName.ToLower());

            if (fileExtension.Equals(".jpg") || fileExtension.Equals(".jpeg") || fileExtension.Equals(".png") || fileExtension.Equals(".bmp"))
            {
                System.Drawing.Bitmap bmpImage = new System.Drawing.Bitmap(fu_Image.PostedFile.InputStream);

                int maxMessageSize = bmpImage.Height * bmpImage.Width;
                string message = tb_message.Text;
                string key = tb_key.Text;

                //string key = "";

                if (key.Equals(null) || key.Equals(""))
                    key = "DefaultPassword";

                string encryptedMessage = EncryptStringAES(message, key);

                if (encryptedMessage.Length < maxMessageSize)
                {
                    //Response.Write("Can Fit");

                    Bitmap stegoedImage = embedText(bmpImage, encryptedMessage);
                    MemoryStream bitmapStream = new MemoryStream();
                    stegoedImage.Save(bitmapStream, ImageFormat.Png);

                    byte[] bitmapBytes = bitmapStream.ToArray();

                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.ContentType = "image/png";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileNameWithoutExtension(fu_Image.FileName) + ".png");
                    Response.BinaryWrite(bitmapBytes);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    alert_placeholder.Visible = true;
                    alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                    alertText.Text = "Selected image too small to hide message!";
                }
            }
            else
            {
                alert_placeholder.Visible = true;
                alert_placeholder.Attributes["class"] = "alert alert-danger alert-dismissable";
                alertText.Text = "File format not supported!";
            }

        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            fu_Image.Attributes.Clear();
            tb_message.Text = String.Empty;
        }

        public enum State
        {
            Hiding,
            Filling_With_Zeros
        };

        private static Bitmap embedText(Bitmap bmp, string text)
        {
            // initially, we'll be hiding characters in the image
            State state = State.Hiding;

            // holds the index of the character that is being hidden
            int charIndex = 0;

            // holds the value of the character converted to integer
            int charValue = 0;

            // holds the index of the color element (R or G or B) that is currently being processed
            long pixelElementIndex = 0;

            // holds the number of trailing zeros that have been added when finishing the process
            int zeros = 0;

            // hold pixel elements
            int R = 0, G = 0, B = 0;

            // pass through the rows
            for (int i = 0; i < bmp.Height; i++)
            {
                // pass through each row
                for (int j = 0; j < bmp.Width; j++)
                {
                    // holds the pixel that is currently being processed
                    Color pixel = bmp.GetPixel(j, i);

                    // now, clear the least significant bit (LSB) from each pixel element
                    R = pixel.R - pixel.R % 2;
                    G = pixel.G - pixel.G % 2;
                    B = pixel.B - pixel.B % 2;

                    // for each pixel, pass through its elements (RGB)
                    for (int n = 0; n < 3; n++)
                    {
                        // check if new 8 bits has been processed
                        if (pixelElementIndex % 8 == 0)
                        {
                            // check if the whole process has finished
                            // we can say that it's finished when 8 zeros are added
                            if (state == State.Filling_With_Zeros && zeros == 8)
                            {
                                // apply the last pixel on the image
                                // even if only a part of its elements have been affected
                                if ((pixelElementIndex - 1) % 3 < 2)
                                {
                                    bmp.SetPixel(j, i, Color.FromArgb(R, G, B));
                                }

                                // return the bitmap with the text hidden in
                                return bmp;
                            }

                            // check if all characters has been hidden
                            if (charIndex >= text.Length)
                            {
                                // start adding zeros to mark the end of the text
                                state = State.Filling_With_Zeros;
                            }
                            else
                            {
                                // move to the next character and process again
                                charValue = text[charIndex++];
                            }
                        }

                        // check which pixel element has the turn to hide a bit in its LSB
                        switch (pixelElementIndex % 3)
                        {
                            case 0:
                                {
                                    if (state == State.Hiding)
                                    {
                                        // the rightmost bit in the character will be (charValue % 2)
                                        // to put this value instead of the LSB of the pixel element
                                        // just add it to it
                                        // recall that the LSB of the pixel element had been cleared
                                        // before this operation
                                        R += charValue % 2;

                                        // removes the added rightmost bit of the character
                                        // such that next time we can reach the next one
                                        charValue /= 2;
                                    }
                                } break;
                            case 1:
                                {
                                    if (state == State.Hiding)
                                    {
                                        G += charValue % 2;

                                        charValue /= 2;
                                    }
                                } break;
                            case 2:
                                {
                                    if (state == State.Hiding)
                                    {
                                        B += charValue % 2;

                                        charValue /= 2;
                                    }

                                    bmp.SetPixel(j, i, Color.FromArgb(R, G, B));
                                } break;
                        }

                        pixelElementIndex++;

                        if (state == State.Filling_With_Zeros)
                        {
                            // increment the value of zeros until it is 8
                            zeros++;
                        }
                    }
                }
            }
            return bmp;
        }

        private static string EncryptStringAES(string plainText, string sharedSecret)
        {
            //if (string.IsNullOrEmpty(plainText))
            //    throw new ArgumentNullException("plainText");
            //if (string.IsNullOrEmpty(sharedSecret))
            //    throw new ArgumentNullException("sharedSecret");

            string outStr = null;                       // Encrypted string to return
            RijndaelManaged aesAlg = null;              // RijndaelManaged object used to encrypt the data.

            try
            {
                // generate the key from the shared secret and the salt
                Rfc2898DeriveBytes key = new Rfc2898DeriveBytes(sharedSecret, _salt);

                // Create a RijndaelManaged object
                aesAlg = new RijndaelManaged();
                aesAlg.Key = key.GetBytes(aesAlg.KeySize / 8);

                // Create a decryptor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for encryption.
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    // prepend the IV
                    msEncrypt.Write(BitConverter.GetBytes(aesAlg.IV.Length), 0, sizeof(int));
                    msEncrypt.Write(aesAlg.IV, 0, aesAlg.IV.Length);
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                    }
                    outStr = Convert.ToBase64String(msEncrypt.ToArray());
                }
            }
            finally
            {
                // Clear the RijndaelManaged object.
                if (aesAlg != null)
                    aesAlg.Clear();
            }

            // Return the encrypted bytes from the memory stream.
            return outStr;
        }
    }
}