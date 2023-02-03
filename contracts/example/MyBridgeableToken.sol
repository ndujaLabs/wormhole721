// SPDX-License-Identifier: Apache2
pragma solidity ^0.8.0;

// Authors: Francesco Sullo <francesco@sullo.co>

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../Wormhole721Upgradeable.sol";

contract MyBridgeableToken is
  Initializable,
  OwnableUpgradeable,
  ERC721Upgradeable,
  ERC721EnumerableUpgradeable,
  Wormhole721Upgradeable
{

  string private _baseTokenURI;

  function initialize(
    string memory name,
    string memory symbol,
    string memory tokenUri
  ) public initializer {
    __Wormhole721_init(name, symbol);
    __Ownable_init();
    _baseTokenURI = tokenUri;
  }

  // solhint-disable-next-line func-name-mixedcase
  function _authorizeUpgrade(address newImplementation) internal virtual override onlyOwner {}

  function mint(address to, uint256 amount) public virtual onlyOwner {
    _mint(to, amount);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal override(ERC721Upgradeable, ERC721EnumerableUpgradeable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
  public
  view
  override(Wormhole721Upgradeable, ERC721Upgradeable, ERC721EnumerableUpgradeable)
  returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return _baseTokenURI;
  }

}
