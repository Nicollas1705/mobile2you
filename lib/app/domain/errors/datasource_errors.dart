abstract class DatasourceError implements Exception {}

class InternalServerError implements DatasourceError {}

class NotFoundError implements DatasourceError {}

class EmptyServerResultError implements DatasourceError {}

class InvalidParamsRequestError implements DatasourceError {}
