
-- Q1 --

-- Releases storage for a player
local function releaseStorage(player)
    --checking if the player isn't nil for easier debugging
    assert(player, "Error: Player object is nil in releaseStorage")
    player:setStorageValue(1000, -1)

end


function onLogout(player)
    --checking if the player isn't nil for easier debugging
    if not player then
        print("Error: Player object is nil in onLogout")
        return
    --using elseif to avoid the need of multiple ends
    elseif player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end

return true

end

--the fucntions need to be called in order to be used
releaseStorage(player)
onLogout(player)



-- Q2 --


function printSmallGuildNames(memberCount)
    --Frist we need to ensure memberCount is a valid number and it's not 0
    if type(memberCount) ~= "number"  then
        print("Error: memberCount must be a number")
        return
    elseif memberCount == 0 then
        print("Error: The guild has no members")
        return
    end

    --Using the string.format to insert values dynamically into the string
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    --Make sure the query returned a valid result
    assert(resultId, "Error: Query returned no results or failed")
    
    --In order to print all the names of all guilds we need to add a loop
    while result.next(resultId) do
        local guildName = result.getString(resultId, "name")
        print(guildName)
    end
 -- lastly we need to free the result set
    result.free(resultId)
end


-- Q3 --
function removePlayerFromParty(playerId, membername)

 --checking if there is a player and if the player belongs to a party 
    player = Player(playerId)
    assert(player, "Error: Player not found")
    local party = player:getParty()
    assert(party, "Error: Player is not in a party")
    
    -- Iterate over the party members
    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
        party:removeMember(Player(membername))
        end
    end
end


-- Q4 --
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Deallocate memory if loading fails
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        delete item; // Deallocate memory if item creation fails
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    } 
    
    else {
        delete player; // Deallocate memory if player is not offline
    }

   
}
