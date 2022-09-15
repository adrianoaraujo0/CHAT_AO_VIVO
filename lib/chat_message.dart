import "package:flutter/material.dart";

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data, this.mine);

  Map<String, dynamic>? data;
  bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data?["senderPhotoUrl"]),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  data?["senderName"],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                data?["imgUrl"] != null
                    ? Image.network(
                        data?["imgUrl"],
                        width: 250,
                      )
                    : Text(
                        data?["texto"],
                        textAlign: mine ? TextAlign.end : TextAlign.start,
                      ),
              ],
            ),
          ),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data?["senderPhotoUrl"]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
