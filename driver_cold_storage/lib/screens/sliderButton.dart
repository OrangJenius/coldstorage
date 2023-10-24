import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';
import 'pengiriman.dart';
import 'package:driver_cold_storage/models/pengantaranModel.dart';

class SlideActionBtn extends StatelessWidget {
  final List<PengantaranModel> pengantaran;
  const SlideActionBtn({
    Key? key,
    required this.pengantaran,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: SlideAction(
        trackBuilder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFF23C9FF),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 10; i++)
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF6AD6F9),
                              size: 30,
                            ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    state.isPerformingAction ? "Loading..." : "Slide to start",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0xFF6AD6F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: state.isPerformingAction
                  ? const CupertinoActivityIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
            ),
          );
        },
        action: () async {
          // Async operation
          await Future.delayed(
            const Duration(milliseconds: 50),
            () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pengirimanScreen(
                        pengantaran: pengantaran,
                      )),
            ),
          );
        },
      ),
    );
  }
}
