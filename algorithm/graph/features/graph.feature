Feature: Testing graph features

  Testing features of graph classes

  Scenario: Undirected Graph Basic Features Testing
    Given a graph instance
    When I read in sample data
    Then I should see sample data read in
    Then I should see adjacent and non-adjacent vertexes
    Then I should see degree_of method work
    Then I should see max_degree method work
    Then I should see self loop is correct


