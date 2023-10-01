import 'package:flutter/material.dart';

import 'package:quiz_app/utility/category_list.dart';
import 'package:quiz_app/presentation/main/difficulty_selection.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DifficultyScreen(
                      categoryIndex: index,
                    )),
          );
        },
        child: Stack(
          children: [
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: categoryDetailList[index].accentColor,
                  child: Center(
                    child: Text(
                      categoryDetailList[index].title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
