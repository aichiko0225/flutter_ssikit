
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';
import 'package:flutter_ssikit_example/sample/home/list_item.dart';

List<Map<String, List>> list1 = [
  {
    '一级1': ['AAA1', 'AAA2', 'AAA3', 'AAA4', 'AAA5', 'AAA6', 'AAA7', 'AAA8']
  },
  {
    '一级2': ['BBB1', 'BBB2', 'BBB3', 'BBB4', 'BBB5']
  },
  {
    '一级3': ['CCC1', 'CCC2', 'CCC3']
  },
  {
    '一级4': ['DDD1', 'DDD2', 'DDD3', 'DDD4']
  },
  {
    '一级5': ['EEE1', 'EEE2', 'EEE3']
  },
  {
    '一级6': ['FFF1']
  },
  {
    '一级7': ['GGG1']
  },
  {
    '一级8': ['HHH1']
  },
  {
    '一级9': ['III1', 'III2']
  }
];

List<Map<String, List>> list = [
  {
    'AAA': [
      {
        'AAA': ['8', '9']
      }
    ]
  },
  {
    'BBB': [
      {
        'BBB': ['5', '6']
      }
    ]
  },
  {
    'CCC': [
      {
        'CCC': ['3', '4']
      }
    ]
  },
  {
    'DDD': [
      {
        'DDD': ['1', '2']
      },
      {
        'DDD1': ['EEE1', 'EEE2']
      }
    ]
  }
];

class MultiPickerExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('多列选择picker'),
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "单列",
              describe: '自定义单列Picker',
              onPressed: () {
                SsiMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Ssi1RowDelegate(firstSelectedIndex: 1),
                  confirmClick: (list) {
                    SsiToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "两列-有联动",
              describe: '自定义Picker',
              onPressed: () {
                SsiMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Ssi2RowDelegate(firstSelectedIndex: 1, secondSelectedIndex: 0),
                  confirmClick: (list) {
                    SsiToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "两列-无联动",
              describe: '自定义Picker，两列直接无联动',
              onPressed: () {
                SsiMultiDataPicker(
                  sync: false,
                  context: context,
                  title: '来源',
                  delegate: Ssi2RowCustomDelegate(firstSelectedIndex: 1, secondSelectedIndex: 0),
                  confirmClick: (list) {
                    SsiToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
            ListItem(
              title: "三列-有联动",
              describe: '自定义三列Picker',
              onPressed: () {
                SsiMultiDataPicker(
                  context: context,
                  title: '来源',
                  delegate: Ssi3RowDelegate(
                      firstSelectedIndex: 1, secondSelectedIndex: 0, thirdSelectedIndex: 0),
                  confirmClick: (list) {
                    SsiToast.show(list.toString(), context);
                  },
                ).show();
              },
            ),
          ],
        ));
  }
}

class Ssi1RowDelegate implements SsiMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Ssi1RowDelegate({this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 1;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    }
    return 0;
  }
}

class Ssi2RowDelegate implements SsiMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Ssi2RowDelegate({this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 2;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    } else if (1 == component) {
      return secondSelectedIndex;
    } else if (2 == component) {
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
      return thirdSelectedIndex;
    }
    return 0;
  }
}

class Ssi3RowDelegate implements SsiMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  Ssi3RowDelegate({
    this.firstSelectedIndex = 0,
    this.secondSelectedIndex = 0,
    this.thirdSelectedIndex = 0,
  });

  @override
  int numberOfComponent() {
    return 3;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      return secondMap.values.first.length;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else if (1 == component) {
      Map<String, List> secondMap = list[firstSelectedIndex];
      List secondList = secondMap.values.first;
      //return secondList[index];
      return secondList[index].keys.first;
    } else {
      Map<String, List> secondMap = list[firstSelectedIndex];
      Map<String, List> thirdMap = secondMap.values.first[secondSelectedIndex];
      return thirdMap.values.first[index];
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    } else if (1 == component) {
      return secondSelectedIndex;
    } else if (2 == component) {
      debugPrint('_thirdSelectedIndex  is selected to $thirdSelectedIndex');
      return thirdSelectedIndex;
    }
    return 0;
  }
}

class Ssi2RowCustomDelegate implements SsiMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;

  Ssi2RowCustomDelegate({this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 2;
  }

  @override
  int numberOfRowsInComponent(int component) {
    if (0 == component) {
      return list.length;
    } else {
      return list.length;
    }
  }

  @override
  String titleForRowInComponent(int component, int index) {
    if (0 == component) {
      return list[index].keys.first;
    } else {
      return list[index].keys.first;
    }
  }

  @override
  double? rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else {
      secondSelectedIndex = row;
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    }
    return secondSelectedIndex;
  }
}
