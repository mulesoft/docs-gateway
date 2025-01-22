# Testing Practices Cheat Sheet

## Testing Libraries and Frameworks

- Jest: Primary testing framework
- React Testing Library: For testing React components
- Enzyme: Additional React component testing utilities
- Mockito: Java mocking framework
- PowerMock: Extended mocking capabilities for Java

## Mocking and Stubbing

### Jest Mocks

```javascript
jest.mock('./moduleName');
jest.spyOn(object, 'methodName').mockImplementation(() => mockReturnValue);
```

### Mockito

```java
when(mockObject.methodName(anyString())).thenReturn(mockValue);
```

### PowerMock

```java
PowerMockito.mockStatic(StaticClass.class);
when(StaticClass.staticMethod()).thenReturn(mockValue);
```

## Fake Implementations

- Create fake classes implementing interfaces for testing
- Use in-memory databases for repository tests
- Implement test doubles for external services

```java
public class FakeUserRepository implements UserRepository {
    private Map<String, User> users = new HashMap<>();

    @Override
    public User findById(String id) {
        return users.get(id);
    }
    // Implement other methods...
}
```

## Test Structure

- Use describe/it blocks for organizing tests
- Group related tests together
- Use beforeEach/afterEach for setup and teardown

```javascript
describe('UserService', () => {
  let userService;
  
  beforeEach(() => {
    userService = new UserService();
  });

  it('should create a user', () => {
    // Test implementation
  });
});
```

## Assertion Styles

- Use expect(...).toBe(...) for Jest assertions
- Use assertThat(...) for Java assertions with Hamcrest matchers

## Test Coverage

- Aim for high test coverage (e.g., >80%)
- Use Jest's coverage reports for JavaScript
- Use JaCoCo for Java code coverage

## Integration Tests

- Test interactions between multiple components
- Use TestContainers for database integration tests

## End-to-End Tests

- Use Cypress for web application E2E tests
- Implement critical user flows

## Best Practices

1. Write tests before implementation (TDD)
2. Keep tests independent and isolated
3. Use descriptive test names
4. Avoid testing implementation details
5. Prefer realistic test data
6. Separate unit tests from integration tests