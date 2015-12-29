class DrawFrame{
  List<String> numbers = new List();
  List<String> results = new List();
  int conversion;

  void setConversion(int conversion){
    this.conversion =conversion;
  }

  int getConversion(){
    return conversion;
  }

  void setNumbers(List<String> element){
    numbers = element;
  }

  List<String> getNumbers(){
    return numbers;
  }

  void setResults(String singleResult){
    results.add(singleResult);
  }

  List<String> getResults(){
    return results;
  }

}