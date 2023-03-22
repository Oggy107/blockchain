// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC721.sol";
import "./Address.sol";

error NotOwner();
error NotAuthorized();

contract ERC721 is IERC721 {
    using Address for address;

    // mapping from owner address to NFT count
    mapping (address => uint256) private _NTFCount;
    // mapping for token id to owner address
    mapping (uint256 => address) private _NTFToOwner;
    // mapping for token id to approved address
    mapping (uint256 => address) private _tokenApproved;
    // mapping from owner to operator approvals
    mapping (address => mapping(address => bool)) private _operatorApproved;

    constructor() {
        
    }

    modifier onlyOwner(uint256 _tokenId) {
        if (msg.sender != ownerOf(_tokenId))
            revert NotOwner();

        _;
    }

    modifier onlyAuthorized(address _spender, uint256 _tokenId) {
        address _owner = ownerOf(_tokenId);

        if (_owner != _spender && _owner != _tokenApproved[_tokenId] && !isApprovedForAll(_owner, _spender))
            revert NotAuthorized();

        _;
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private onlyAuthorized(_from, _tokenId) {
        require(isTokenValid(_tokenId), "token is not valid");

        _NTFToOwner[_tokenId] = _to;
        _NTFCount[_from] = _NTFCount[_from] - 1;
        _NTFCount[_to] = _NTFCount[_to] + 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function _checkOnERC721Received(address _from, address _to, uint256 _tokenId, bytes memory _data) private returns(bool) {
        if (_to.isContract()) {
            // calling onERC721Received function or method on contract at address _to
            // A wallet/broker/auction application MUST implement the wallet interface if it will accept safe transfers.
            // so we are checking if it(contract) has implimented it or not
            return IERC721TokenReciever(_to).onERC721Received(
                msg.sender,
                _from,
                _tokenId,
                _data
            ) == IERC721TokenReciever.onERC721Received.selector;
        } else {
            return true;
        }
    }

    function isTokenValid(uint256 _tokenId) public view returns (bool) {
        return _NTFToOwner[_tokenId] != address(0);
    }

    function getInterfaceIdIERC721() public pure returns (bytes4) {
        return type(IERC721).interfaceId;
    }

    function getInterfaceIdIERC165() public pure returns (bytes4) {
        return type(IERC165).interfaceId;
    }

    function supportsInterface(bytes4 _interfaceID) external pure returns(bool) {
        return _interfaceID == type(IERC721).interfaceId || _interfaceID == type(IERC165).interfaceId;
    }

    function balanceOf(address _owner) public view returns(uint256) {
        return _NTFCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns(address) {
        return _NTFToOwner[_tokenId];
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public payable {
        _transfer(_from, _to, _tokenId);

        require(_checkOnERC721Received(_from, _to, _tokenId, _data), "Contract does not support safe transfer");
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }


    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        _transfer(_from, _to, _tokenId);
    }

    function approve(address __approved, uint256 _tokenId) external onlyOwner(_tokenId) payable {
        require(isTokenValid(_tokenId), "token is not valid");

        _tokenApproved[_tokenId] = __approved;
        emit Approval(msg.sender, __approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        _operatorApproved[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function getApproved(uint256 _tokenId) external view returns(address) {
        return _tokenApproved[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _operatorApproved[_owner][_operator];
    }

    function mint(address _to, uint256 _tokenId) external {
        require(_NTFToOwner[_tokenId] == address(0), "token already minted");

        _NTFCount[_to] = _NTFCount[_to] + 1;
        _NTFToOwner[_tokenId] = _to;
    }
}