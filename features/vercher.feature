Feature: Update version recursively
    Scenario: update a directory by its file name
        Given a directory named "test"
        And a file named "test/test.html" with: 
            """
            <script src="a.js"></script>
            """
        When I successfully run `vercher update -f a.js`
        Then the file "test/test.html" should contain "v="

    Scenario: update single file by its name with extension
        Given a file named "test.html" with:
            """
            <script src="abc.js"></script>
            <script src="/abc.js"></script>
            <script src="http://abc.js"></script>
            <script src="http://c/abc.js"></script>
            <script src="http://c/abc.js?v=123"></script>
            <link rel="c.css"></link>
            <link rel="/c.css"></link>
            <link rel="http://d/c.css"></link>
            <link rel="http://d/c.css?v=123"></link>
            <link rel="${VelocityVar}/d/c.css?v=123"></link>
            <link rel="${VelocityVar}/d/c.css"></link>
            <script src="${VelocityVar}/c/abc.js?v=123"></script>
            <script src="${VelocityVar}/c/abc.js"></script>
            """
        When I successfully run `vercher update -f a.js`

        Given a file named "test.html" with: 
            """
            <script src="://abc.js"></script>
            """
        When I successfully run `vercher update -f abc.js`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <script src="/abc.js"></script>
            """
        When I successfully run `vercher update -f abc.js`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <script src="/d/abc.js"></script>
            """
        When I successfully run `vercher update -f abc.js`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <script src="${a}/abc.js"></script>
            """
        When I successfully run `vercher update -f abc.js`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <link rel="stylesheet" href="abc.css">
            """
        When I successfully run `vercher update -f abc.css`

        Given a file named "test.html" with: 
            """
            <link rel="stylesheet" href="/abc.css">
            """
        When I successfully run `vercher update -f abc.css`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <link rel="stylesheet" href="a/abc.css">
            """
        When I successfully run `vercher update -f abc.css`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <link rel="stylesheet" href="://c/abc.css">
            """
        When I successfully run `vercher update -f abc.css`
        Then the file "test.html" should contain "v="

        Given a file named "test.html" with: 
            """
            <link rel="stylesheet" href="${a}/c/abc.css">
            """
        When I successfully run `vercher update -f abc.css`
        Then the file "test.html" should contain "v="













