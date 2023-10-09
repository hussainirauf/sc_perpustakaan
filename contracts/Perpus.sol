// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.20;

contract Perpus {
    mapping(uint => BookDetail) public listofBooks; 

    address public admin;

    struct BookDetail {
        uint isbn;
        string title;
        uint256 yearBookCreated;
        string writerName;
        address writerAddress;
    }

    event BookCreated(uint indexed isbn, address indexed sender, uint256 timestamp);
    event BookUpdate(uint indexed isbn, address indexed sender, uint256 timestamp);
    event BookDeleted(uint indexed isbn, address indexed sender, uint256 timestamp);

    constructor(){
        admin =msg.sender;
    }

    //tambah buku
    function tambahBuku(
        uint _isbn,
        string memory _title,
        uint256 _yearBookCreated,
        string memory _writerName,
        address _writerAddress
    ) public {
        require(admin == msg.sender, "sender is not admin");
        listofBooks [_isbn] = BookDetail(_isbn, _title, _yearBookCreated, _writerName, _writerAddress);

        emit BookCreated(_isbn, msg.sender, block.timestamp);

    }

    //hapus buku
    function hapusBuku(uint _isbn) public{
        require(admin == msg.sender, "sender is not admin");
        listofBooks [_isbn] = BookDetail(0,string(""), 0, string(""),address(0));

        emit BookDeleted(_isbn, msg.sender, block.timestamp);
    }

    //get buku by isbn
    function getBuku(uint _isbn) public view returns 
    (
        uint __isbn,
        string memory __title,
        uint256 __yearBookCreated,
        string memory __writerName,
        address __writerAddress
    ){

        __isbn = listofBooks [_isbn].isbn;
        __title = listofBooks [_isbn].title;
        __yearBookCreated = listofBooks [_isbn].yearBookCreated;
        __writerName = listofBooks [_isbn].writerName;
        __writerAddress = listofBooks [_isbn].writerAddress;
    
        return( __isbn, __title, __yearBookCreated, __writerName, __writerAddress);
    }

    //update
    function updateTitleBuku(uint _isbn, string memory _title) public {
        require(admin == msg.sender, "sender is not admin");
        listofBooks [_isbn].title = _title;

        emit BookUpdate(_isbn, msg.sender, block.timestamp);
    }
}