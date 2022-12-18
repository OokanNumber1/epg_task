void responseHelper(List response,bool isOneResponseExpected ){
  if (response.isEmpty) {
    print("No Program found with the given details, kindly check again");
  } else {
  isOneResponseExpected ?   print("=====Program Found========\n ${response[0]}"):  print("=====Program Found========\n $response");
  }
}