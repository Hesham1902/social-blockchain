pragma solidity ^0.5.0;

contract SocialNetwork{
    string public name;
    uint public postCount = 0;
    mapping(uint => Post) public posts;


    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    } 
    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author

    );
    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author

    );

    constructor() public{
        name = "Dapp University Social Network";
    }


    function createPost(string memory _content) public{ 
        // Require valid content
        require(bytes(_content).length > 0);

        // Increment the post count
        postCount ++ ; 
        // Create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender);

        emit PostCreated(postCount, _content, 0, msg.sender);

    }




    function tipPost(uint _id) public payable {
        // Make sure the id is valid
        require(_id > 0 && _id <= postCount);
        //Fetch The Post
        Post memory _post = posts[_id];
        //Fetch The Author
        address payable _author = _post.author;
        //Pay The Author by sending them Ether
        address(_author).transfer(msg.value);
        //Increase The Tip Amount
        _post.tipAmount = _post.tipAmount + msg.value;
        //Update The Post
        posts[_id] = _post;
        // Trigger an event
        emit PostTipped(postCount, _post.content, _post.tipAmount , _author);

    }









}