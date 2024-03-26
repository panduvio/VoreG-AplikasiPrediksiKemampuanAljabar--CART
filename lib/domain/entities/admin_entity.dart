class AdminEntity {
  final String name;
  final String password;

  AdminEntity({
    required this.name,
    required this.password,
  });
}

List<AdminEntity> admin = [
  AdminEntity(name: 'panduvio', password: '200312614052'),
  AdminEntity(name: 'admin1', password: '12345678'),
];
