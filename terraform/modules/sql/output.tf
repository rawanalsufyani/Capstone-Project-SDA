output "server_id" {
  value = azurerm_mssql_server.sql_server.id
}

output "db_id" {
  value = azurerm_mssql_database.sql_db.id
}
output "sql_fqdn" { value = azurerm_mssql_server.sql_server.fully_qualified_domain_name }
