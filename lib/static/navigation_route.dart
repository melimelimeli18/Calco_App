enum NavigationRoute {
  welcomeRoute("/welcome"),
  homeRoute("/"),
  loginRoute("/login"),
  registerRoute("/register"),
  roleUserRoute("/user-role"),
  meditationHomeRoute("/meditation-home"),
  meditationGuideRoute("meditation-guide"),
  meditationReviewRoute("/meditation-review");

  const NavigationRoute(this.name);
  final String name;
}
