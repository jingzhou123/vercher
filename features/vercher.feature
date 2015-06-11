Feature: Update version recursively

    Scenario: update by file name with extension
        Given a file named "test.html" with:
            """
            <script src="abc.js"></script>
            """
        When I successfully run `vercher update -f a.js`
        Then file "test.html" should contain lastest version info 
