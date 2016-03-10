class DrawFrame{
  List<String> numbers = new List();
  List<String> results = new List();
  List<String> origin =new List();
  int conversion;

  void setConversion(int conversion){//设置进制
    this.conversion =conversion;
  }

  int getConversion(){//获取进制
    return conversion;
  }

  void setNumbers(List<String> element){//设置数字
    numbers = element;
  }

  List<String> getNumbers(){//获得数字
    return numbers;
  }


  void setResults(String singleResult){//中间环节数字
    results.add(singleResult);
  }

  List<String> getResults(){
    return results;
  }

  void setFormer(String singleResult){
    origin.add(singleResult);
  }

  List<String> getFormer(){
    return origin ;
  }


}