using Microsoft.AspNet.SignalR;
using OTR.Interface;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace InstaKG
{
    public class ChatHub : Hub
    {
        #region Data Members

        private static List<UserDetail> ConnectedUsers = new List<UserDetail>();
        private static List<MessageDetail> CurrentMessage = new List<MessageDetail>();

        // Fix Check the Public and Private properties of this page of coding
        // Variables for Private Chat
        // toUser = Bob, fromUser = Alice
        
        // Custom to utilise OTR
        private string msgEncryptState; // Create set and get method
        private static string decryptedOTR;  // Create set and get method
        public static bool inPrivate = false; 

        private UserDetail toUser;
        private UserDetail fromUser;

        private string fromUserId;
        private string toUserId;

        //OTR Message Container Empty
        private String privateMessage;
        private int privateMessagePos = 0;


        // Declare OTR Variables Empty
        private OTRSessionManager _toUser_otr_session_manager = null;
        private OTRSessionManager _fromUser_otr_session_manager = null;

        private string _toUser_unique_id;
        private string _fromUser_unique_id;

        // Client unique IDs and DES Keys Empty
        private string _fromUser_buddy_unique_id = string.Empty;
        private string _toUser_buddy_unique_id = string.Empty;

        private DSAKeyParams _fromUser_des_key_object = null;
        private DSAKeyParams _toUser_des_key_object = null;
        
        #endregion Data Members

        #region Methods

        public void Connect(string userName)
        {
            var id = Context.ConnectionId;

            if (ConnectedUsers.Count(x => x.ConnectionId == id) == 0)
            {
                ConnectedUsers.Add(new UserDetail { ConnectionId = id, UserName = userName });

                // send to caller
                Clients.Caller.onConnected(id, userName, ConnectedUsers, CurrentMessage);

                // send to all except caller client
                Clients.AllExcept(id).onNewUserConnected(id, userName);
            }
        }

        public void SendMessageToAll(string userName, string message)
        {
            inPrivate = false;
            // store last 100 messages in cache
            AddMessageinCache(userName, message);

            // Broad cast message
            Clients.All.messageReceived(userName, message);
        }

        public void SetMsgEncryptState(string inMsgEncryptState) {
            msgEncryptState = inMsgEncryptState;
        }

        public string GetMsgEncryptState () {
            return msgEncryptState;
        }

        private void SetDecryptedOTR(string inDecryptedOTR) {
            decryptedOTR = inDecryptedOTR;
        }

        public static string GetDecryptedOTR()
        {
            return decryptedOTR;
        }

        public void SetPrivateMsg(string inPrivateMessage) {
            privateMessage = inPrivateMessage;

        }

        public string GetPrivateMsg() {
            return privateMessage;
        }

        private void SetDSAPublicKeys() {
            // Alice and Bob want to use their DSA keys
            // Set DSA Public Keys
            // Will fix it to be auto generated, or plausible leave it since it is public key
            // Research into it more
            string _dsa_key_1_p = "00e24d61e1c20661e7514e594cc959859c62eeade72893a4772d3efd246abeb5a2848fb5e4b05a9c5b4edb5b67e53cdeb8337a8e4e44b26a6c1927be024695c83d";
            string _dsa_key_1_q = "00c873b36de07d9ebea48ee96bcc259b94304c65d9";
            string _dsa_key_1_g = "008028acddbd4e51ba344c7e5bacdaf68ecfce35beead41cf12b3d1093c479c24148d817645a4123604774a8824be2a47e19016e1b4247ea40413cf478fff9009c";
            string _dsa_key_1_x = "333715606eebd0925e79da44e02bdfd0cdba5a";

            string _dsa_key_2_p = "00e5cc7a4d6cd189b8d176086aec944c2db1e7f8bf13e6b20a3456d8bb9a33d7bb8960de8d1eb4fdf1fbd4ccbb3ecd7ca927169247d2cabff935a70ddbccae6d69";
            string _dsa_key_2_q = "00c9fefa6732d392a57ecebdf6e990887ea52d2835";
            string _dsa_key_2_g = "0e9135dc3bd3479de6aae872781ad95703a107915689e655f3ddb2bf99c79af5cec4df5bafe5e502ceb0ca26bac67eefcace2e9f42dc972af4ab0033eeeb583e";
            string _dsa_key_2_x = "00a150c9bec477f9713768f6fc1dfd784702c4ffcd";

            _fromUser_des_key_object = new DSAKeyParams(_dsa_key_1_p, _dsa_key_1_q, _dsa_key_1_g, _dsa_key_1_x);
            _toUser_des_key_object = new DSAKeyParams(_dsa_key_2_p, _dsa_key_2_q, _dsa_key_2_g, _dsa_key_2_x);
        }

        public void SendPrivateMessage(string toUserIdPassedIn, string message)
        {
            inPrivate = true;
            fromUserId = Context.ConnectionId;
            // Passed in parameter is in String
            toUserId = toUserIdPassedIn;

            // Set private message to be processed
            SetPrivateMsg(message);

            // Retrieve id of caller and target client
            // May delete the following line
            // toUser = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == toUserId);
            fromUser = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == fromUserId);
            toUser = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == toUserId);
            
            // OTR Coding Section
            _fromUser_unique_id = fromUser.UserName;
            _toUser_unique_id = toUser.UserName;
            SetDSAPublicKeys();

            // OTR Processes
            _fromUser_buddy_unique_id = _toUser_unique_id; // fromUser_buddy, which is > Bob
            _toUser_buddy_unique_id = _fromUser_unique_id; // Bob's buddy, which is > Alice

            _fromUser_otr_session_manager = new OTRSessionManager(_fromUser_unique_id);
            _toUser_otr_session_manager = new OTRSessionManager(_toUser_unique_id);

            // Important handler - Alice OTR Event handler
            _fromUser_otr_session_manager.OnOTREvent += new OTREventHandler(OnFromUserOTRMangerEventHandler);
            _toUser_otr_session_manager.OnOTREvent += new OTREventHandler(OnToUserOTRMangerEventHandler);

            // OTR creates random keys, both do not have DSA Keys
            // Critical creating session, joining thru buddy's key
            _fromUser_otr_session_manager.CreateOTRSession(_fromUser_buddy_unique_id, true);
            _toUser_otr_session_manager.CreateOTRSession(_toUser_buddy_unique_id, true);

            //Alice requests an OTR session with Bob  using OTR version 2
            _fromUser_otr_session_manager.RequestOTRSession(_fromUser_buddy_unique_id, OTRSessionManager.GetSupportedOTRVersionList()[0]);


            //Backup copy
            // SendPrivateMessage Chatting Section
            //if (toUser != null && fromUser != null)
            //{
            //    // send to
            //    Clients.Client(toUserId).sendPrivateMessage(fromUserId, fromUser.UserName, message);

            //    // send to caller user
            //    Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, message);
            //}

        }

        // Alice OTR Handler
        private void OnFromUserOTRMangerEventHandler(object source, OTREventArgs e)
        {

            switch (e.GetOTREvent())
            {
                case OTR_EVENT.MESSAGE:
                    Debug.WriteLine("{0}: {1} - FROM ALICE HANDLER\n", e.GetSessionID(), e.GetMessage());

                    // send to
                    //Clients.Client(fromUserId).sendPrivateMessage(toUserId, toUser.UserName, e.GetMessage());
                    // send to caller user
                    //Clients.Caller.sendPrivateMessage(fromUserId, toUser.UserName, e.GetMessage());

                    if (privateMessagePos == 0) { 
                        privateMessagePos++;
                    _fromUser_otr_session_manager.EncryptMessage(_fromUser_buddy_unique_id, privateMessage);
                    }


                    break;

                case OTR_EVENT.SEND:


                    if (toUser != null && fromUser != null)
                    {
                        SetMsgEncryptState(Convert.ToString(_fromUser_otr_session_manager.GetSessionMessageState(_fromUser_buddy_unique_id)));
                        //msgEncryptState = Convert.ToString(_fromUser_otr_session_manager.GetSessionMessageState(_fromUser_buddy_unique_id));

                        if (msgEncryptState == "MSG_STATE_ENCRYPTED" && privateMessagePos > 0)
                        {
                            // The correct encryption area EG
                            ////send to
                            Clients.Client(toUserId).sendPrivateMessage(fromUserId, fromUser.UserName, e.GetMessage());
                            ////send to caller user
                            Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, e.GetMessage());

                            
                        }

                        SendDataOnNetwork(_fromUser_unique_id, e.GetMessage());

                        // send to
                        //Clients.Client(fromUserId).sendPrivateMessage(toUserId, toUser.UserName, e.GetMessage());

                        // send to caller user
                        //Clients.Caller.sendPrivateMessage(fromUserId, toUser.UserName, e.GetMessage());
                    }



                    break;
                case OTR_EVENT.ERROR:
                    
                        Debug.WriteLine("Alice: OTR Error: {0} \n", e.GetErrorMessage());
                        Debug.WriteLine("Alice: OTR Error Verbose: {0} \n", e.GetErrorVerbose());
                    

                    break;
                case OTR_EVENT.READY:

                    Debug.WriteLine(e.GetSessionID());
                    privateMessagePos++;
                    //msgEncryptState = true;
                    _fromUser_otr_session_manager.EncryptMessage(_fromUser_buddy_unique_id, privateMessage);
                    // msgEncryptState == true


                    break;
                case OTR_EVENT.DEBUG:

                    Debug.WriteLine("Alice: " + e.GetMessage() + "\n");

                    break;
                case OTR_EVENT.EXTRA_KEY_REQUEST:


                    break;
                case OTR_EVENT.SMP_MESSAGE:


                    Debug.WriteLine("Alice: "+ "SMP Line" + e.GetMessage() + "\n");



                    break;
                case OTR_EVENT.CLOSED:



                    Debug.WriteLine("Alice: Encrypted OTR session with {0} closed \n", e.GetSessionID());

                    break;

            }

        }

        private void OnToUserOTRMangerEventHandler(object source, OTREventArgs e)
        {

            switch (e.GetOTREvent())
            {
                case OTR_EVENT.MESSAGE:

                    Debug.WriteLine("{0}: {1} \n - FROM BOB HANDLER", e.GetSessionID(), e.GetMessage());
                    
                    // Asses the security
                    SetDecryptedOTR(e.GetMessage());
                    //decryptedOTR = e.GetMessage();

                    ////// send to
                    //Clients.Client(toUserId).sendPrivateMessage(fromUserId, fromUser.UserName, e.GetMessage());

                    ////// send to caller user
                    //Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, e.GetMessage());
                    //SendPrivateMessage Chatting Section
                    if (privateMessagePos == 0)
                    {
                        privateMessagePos++;
                        _toUser_otr_session_manager.EncryptMessage(_toUser_buddy_unique_id, privateMessage);

                    //    // send to
                    //    Clients.Client(toUserId).sendPrivateMessage(fromUserId, fromUser.UserName, privateMessage);

                    //    // send to caller user
                    //    Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, privateMessage);
                    }


                    break;

                case OTR_EVENT.SEND:


                    if (toUser != null && fromUser != null)
                    {
                        SendDataOnNetwork(_toUser_unique_id, e.GetMessage());
                        
                        // send to
                        //Clients.Client(toUserId).sendPrivateMessage(fromUserId, fromUser.UserName, e.GetMessage());

                        // send to caller user
                        //Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, e.GetMessage());
                    }

                    break;
                case OTR_EVENT.ERROR:

                    Debug.WriteLine("Bob: OTR Error: {0} \n", e.GetErrorMessage());
                    Debug.WriteLine("Bob: OTR Error Verbose: {0} \n", e.GetErrorVerbose());

                    break;
                case OTR_EVENT.READY:


                    Debug.WriteLine("Bob: Encrypted OTR session with {0} established \n", e.GetSessionID());


                    break;
                case OTR_EVENT.DEBUG:

                    Debug.WriteLine("Bob: " + e.GetMessage() + "\n");

                    break;
                case OTR_EVENT.EXTRA_KEY_REQUEST:


                    break;
                case OTR_EVENT.SMP_MESSAGE:


                    Console.WriteLine("Bob: " + "SMP Line" + e.GetMessage() + "\n");



                    break;
                case OTR_EVENT.CLOSED:



                    Debug.WriteLine("Bob: Encrypted OTR session with {0} closed \n", e.GetSessionID());


                    break;

            }

        }


        private void SendDataOnNetwork(string my_unique_id, string otr_data)
        {
            if (my_unique_id == _fromUser_unique_id)
            {
                _toUser_otr_session_manager.ProcessOTRMessage(_toUser_buddy_unique_id, otr_data);
            }
            else if (my_unique_id == _toUser_unique_id)
            {
                _fromUser_otr_session_manager.ProcessOTRMessage(_fromUser_buddy_unique_id, otr_data);
            }

        }

        // Fix it, no checking whether it is terminated gracefully or on force
        // stopCalled is undefined
        public override System.Threading.Tasks.Task OnDisconnected(bool stopCalled)
        {
            var item = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId);
            if (item != null)
            {
                ConnectedUsers.Remove(item);

                var id = Context.ConnectionId;
                Clients.All.onUserDisconnected(id, item.UserName);
            }

            return base.OnDisconnected(stopCalled);
        }

        #endregion Methods

        #region private Messages

        private void AddMessageinCache(string userName, string message)
        {
            CurrentMessage.Add(new MessageDetail { UserName = userName, Message = message });

            if (CurrentMessage.Count > 100)
                CurrentMessage.RemoveAt(0);
        }

        #endregion private Messages
    }
}