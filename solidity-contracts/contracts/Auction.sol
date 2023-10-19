//SPDX-License-Identifier: Unlicense
pragma solidity  v0.8.21;

interface Auction {

    enum AuctionType {
        Forward,
        Reverse,
        Double
    }

    enum AuctionStatus {
        Cancelled,
        Closed,
        Expired,
        Open,
        Pending
    }

    enum LotStatus {
        Active,
        Expired
    }

    enum ItemStatus {
        Sold,
        Listed,
        Unlisted
    }

    struct Auction {
        uint256 auctionId;
        Status status,
        uint256 startDate;
        uint256 endDate;
        address seller;
        string currency;
        AuctionType auctionType;
        mapping(address => Bid) bidders;
    }

    struct Bid {
        uint256 bidId;
        uint256 value;
        uint256 itemId;
        address bidder;
    }

    struct Lot {
        uint256 lotId;
        LotStatus status;
        mapping(uint256 => Item) items;
    }

    struct Item {
        uint256 itemId;
        uint256 reservePrice;
        ItemStatus status;
    }

    function create(
        address seller, 
        string currency,
        uint256 startDate,
        uint256 endDate,
        AuctionType auctionType
    ) external;

    function cancel(uint256 auctionId) external;

    function open(uint256 auctionId) external;

    function close(uint256 auctionId) external;

    function placeBid(address bidder, uint256 itemId, uint256 offer) external;

    function retractBid(address bidder, uint256 bidId) external;

    function getHighestBid() external returns(Bid);

}