-- chunkname: @modules/logic/video/adjust/MediaPlayer_adjust.lua

module("modules.logic.video.adjust.MediaPlayer_adjust", package.seeall)

local MediaPlayer_adjust = class("MediaPlayer_adjust")

function MediaPlayer_adjust:CloseMedia()
	return
end

MediaPlayer_adjust.instance = MediaPlayer_adjust.New()

return MediaPlayer_adjust
