import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20.0,
            margin: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://images.unsplash.com/photo-1528465424850-54d22f092f9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBwaG90b3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.fitWidth,
              height: 180,
              width: double.infinity,
            ),
          ),
          ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  "https://www.bing.com/th?id=OIP.NfJCEFT-pMf8Me5cyKfgRgHaFH&w=150&h=104&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text("Thamer Kehail"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 16,
                                    )
                                  ],
                                ),
                                const Text("28/3/2023 at 12:30 pm"),
                              ],
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  size: 20,
                                )),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                          color: Colors.grey[300],
                        ),
                        const Text(
                          "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                        ),
                        Wrap(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "#Flutter",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          'https://tse4.mm.bing.net/th/id/OIP.-DS3SqjrxNhcwCUkfuT1RwHaEt?w=264&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                          fit: BoxFit.fitWidth,
                          height: 180,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.favorite_border, color: Colors.red),
                                Text("120"),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.comment_bank_outlined,
                                  color: Colors.red,
                                ),
                                Text("120 comments"),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage: NetworkImage(
                                      "https://www.bing.com/th?id=OIP.NfJCEFT-pMf8Me5cyKfgRgHaFH&w=150&h=104&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Write a comment ...."),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                Text("Like"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
