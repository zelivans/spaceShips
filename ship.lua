ship = {
    health = 100,
    damage = function(player, d)
        player.health = player.health - d
    end
}

-- About classes: https://www.reddit.com/r/love2d/comments/440q29/help_eli5_how_lua_classes_work/
