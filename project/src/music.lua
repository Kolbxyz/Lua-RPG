-- music.lua
local methods = {}

function methods.load(state, musicName, stopOthers, shouldPlay)
    local musicFile = love.audio.newSource(string.format("assets/music/%s.wav", musicName or "music"), "stream")
    local music = setmetatable({name = musicName, instance = musicFile}, {__index = methods})

    musicFile:setLooping(true)
    table.insert(state.music, music)
    if shouldPlay then
        music:Play(state, stopOthers)
    end
end

function methods:Play(state, stopOthers)
    local music = self

    if not music then
        return 84
    end
    if stopOthers then
        for _, playing_music in pairs(state.music) do
            if playing_music.instance:isPlaying() and playing_music.instance ~= music.instance then
                playing_music.instance:stop()
            end
        end
    end
    music.instance:play()
end

return methods