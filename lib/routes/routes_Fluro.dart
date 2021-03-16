part of 'app_fluro.dart';

class RoutesFluro {
  
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "ROUTE WAS NOT FOUND",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                  ),
                  child: Text(
                    "Close App",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });

    router.define("/", handler: authHandler);
    router.define("/addEditSpending", handler: spendingFromHandler);
    router.define("/addEditIncome", handler: incomeFromHandler);

    router.define("/account", handler: accountHandler);
    router.define("/addEditAccount", handler: accountFromHandler);
    
    router.define("/category", handler: categoryHandler);
    router.define("/addEditCategory", handler: categoryFromHandler);
  }
}
