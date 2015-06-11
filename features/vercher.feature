Feature: Update version recursively

    Scenario: update by file name with extension
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

