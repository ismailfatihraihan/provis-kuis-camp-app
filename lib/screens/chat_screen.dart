import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;
  final DateTime time;
  
  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [
    Message(
      text: 'Hello! How can I help you with your camping gear rental?',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];
  
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  
  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    _textController.clear();
    
    setState(() {
      _messages.add(Message(
        text: text,
        isMe: true,
        time: DateTime.now(),
      ));
    });
    
    // Simulate admin response after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      
      setState(() {
        _messages.add(Message(
          text: _getAutoReply(text),
          isMe: false,
          time: DateTime.now(),
        ));
      });
    });
  }
  
  String _getAutoReply(String text) {
    final lowerText = text.toLowerCase();
    
    if (lowerText.contains('hello') || lowerText.contains('hi')) {
      return 'Hello there! How can I help you today?';
    } else if (lowerText.contains('tent') || lowerText.contains('tenda')) {
      // return 'We have various tents available for rent, from 2-person to 6-person t  {
      return 'We have various tents available for rent, from 2-person to 6-person tents. Would you like me to tell you more about our tent options?';
    } else if (lowerText.contains('sleeping') || lowerText.contains('bag')) {
      return 'Our sleeping bags are rated for different temperatures, from summer use to winter camping. Do you have any specific temperature requirements?';
    } else if (lowerText.contains('price') || lowerText.contains('cost') || lowerText.contains('harga')) {
      return 'Our rental prices vary depending on the item and duration. Most items range from Rp 5k to Rp 15k per day. You can see detailed pricing on each product page.';
    } else if (lowerText.contains('discount') || lowerText.contains('promo')) {
      return 'We currently have a weekend package deal with 21% off! You can check our promotions page for more special offers.';
    } else if (lowerText.contains('deposit') || lowerText.contains('jaminan')) {
      return 'Yes, we require a refundable deposit that varies based on the equipment value. The deposit will be returned when you bring back the items in good condition.';
    } else if (lowerText.contains('thank')) {
      return 'You\'re welcome! Feel free to ask if you have any other questions.';
    } else {
      return 'Thanks for your message. Our team will get back to you shortly. Is there anything specific about camping gear you\'d like to know?';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
		  children: [
			const CircleAvatar(
			  backgroundImage: NetworkImage(
				'https://randomuser.me/api/portraits/women/45.jpg',
			  ),
			),
			const SizedBox(width: 12),

			// Gunakan Expanded agar teks tidak menyebabkan overflow
			Expanded(
			  child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
				  const Text(
					'Admin Support',
					overflow: TextOverflow.ellipsis,  // Hindari overflow teks panjang
					maxLines: 1, // Batasi hanya 1 baris
				  ),
				  Text(
					'Online',
					style: TextStyle(
					  fontSize: 12,
					  color: Colors.white.withOpacity(0.8),
					),
					overflow: TextOverflow.ellipsis, // Hindari overflow pada teks status
					maxLines: 1,
				  ),
				],
			  ),
			),
		  ],
		),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat header with info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You can chat with our admin for assistance with rentals, product info, or camping tips.',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final message = _messages[_messages.length - index - 1];
                return _buildMessage(message);
              },
            ),
          ),
          
          // Divider
          const Divider(height: 1),
          
          // Input area
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Attachment functionality
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    // Camera functionality
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMessage(Message message) {
    final time = '${message.time.hour}:${message.time.minute.toString().padLeft(2, '0')}';
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/45.jpg'),
              radius: 16,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isMe 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: message.isMe ? const Radius.circular(16) : const Radius.circular(0),
                  bottomRight: message.isMe ? const Radius.circular(0) : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      color: message.isMe 
                          ? Colors.white.withOpacity(0.7) 
                          : Colors.black.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (message.isMe) ...[
            const SizedBox(width: 8),
            Icon(
              message.isMe ? Icons.done_all : null,
              size: 16,
              color: Colors.blue,
            ),
          ],
        ],
      ),
    );
  }
}

