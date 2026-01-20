-- chunkname: @modules/logic/video/AvProMgrConfig.lua

module("modules.logic.video.AvProMgrConfig", package.seeall)

local AvProMgrConfig = _M

AvProMgrConfig.UrlVideo = "ui/viewres/video/videoplayer.prefab"
AvProMgrConfig.UrlVideoCompatible = "ui/viewres/video/videocompatible.prefab"
AvProMgrConfig.UrlVideoDisable = "ui/viewres/video/videodisable.prefab"
AvProMgrConfig.UrlFightVideo = "ui/viewres/fight/fightvideo.prefab"
AvProMgrConfig.UrlFightVideoCompatible = "ui/viewres/fight/fightvideocompatible.prefab"
AvProMgrConfig.UrlStoryVideo = "ui/viewres/story/storyviewvideo.prefab"
AvProMgrConfig.UrlStoryVideoCompatible = "ui/viewres/story/storyviewvideocompatible.prefab"
AvProMgrConfig.UrlNicknameVideo = "ui/viewres/login/nicknamevideo.prefab"
AvProMgrConfig.UrlNicknameVideoCompatible = "ui/viewres/login/nicknamevideocompatible.prefab"
AvProMgrConfig.URLRolesprefabDict = {
	["rolesstory/rolesprefab/305901_door_p/305901_door_p_light.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_light_compatible.prefab",
	["rolesstory/rolesprefab/305901_door_p/305901_door_p.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_compatible.prefab"
}

function AvProMgrConfig.getPreloadList()
	return {
		AvProMgrConfig.UrlVideo,
		AvProMgrConfig.UrlVideoCompatible,
		AvProMgrConfig.UrlVideoDisable
	}
end

return AvProMgrConfig
