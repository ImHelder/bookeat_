import 'package:bookeat/components/Common/customCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RestaurantFeedback extends StatelessWidget {
  const RestaurantFeedback({super.key, required this.feedbacks});

  final List feedbacks;
  @override
  Widget build(BuildContext context) {
    final currentFeedbacks =
        List.generate(feedbacks[0].length, (index) => feedbacks[0][index]);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3 * (kIsWeb ? 1.5 : 1.1),
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: currentFeedbacks.length,
            itemBuilder: (BuildContext context, int index) {
              return currentFeedbacks.isNotEmpty
                  ? CustomCard(
                      title: currentFeedbacks[index]["name"],
                      description: currentFeedbacks[index]["feedback"],
                      picture: currentFeedbacks[index]["picture"],
                      leftImageData: currentFeedbacks[index]["notation"],
                      onPress: () {},
                      onPress2: () {},
                      isChoice: false,
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text("Oops, pas de commentaire trouvé"))
                      ],
                    );
            }),
      ),
    );
  }
}
