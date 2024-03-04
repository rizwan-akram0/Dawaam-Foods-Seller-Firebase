import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/chats_controller.dart';
import 'package:dawaam_seller/services/store_services.dart';
import 'package:dawaam_seller/views/messages_screen/components/chat_bubble.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: chat, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(purpleColor),
                    ))
                  : Expanded(
                      child: StreamBuilder(
                      stream: StoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(purpleColor),
                          ));
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child:
                                "Send a message...".text.color(darkGrey).make(),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: chatBubble(data, context));
                            }).toList(),
                          );
                        }
                      },
                    )),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: purpleColor,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12.0))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
