module("modules.logic.video.AvProMgrConfig", package.seeall)

local var_0_0 = _M

var_0_0.UrlVideo = "ui/viewres/video/videoplayer.prefab"
var_0_0.UrlVideoCompatible = "ui/viewres/video/videocompatible.prefab"
var_0_0.UrlVideoDisable = "ui/viewres/video/videodisable.prefab"
var_0_0.UrlFightVideo = "ui/viewres/fight/fightvideo.prefab"
var_0_0.UrlFightVideoCompatible = "ui/viewres/fight/fightvideocompatible.prefab"
var_0_0.UrlStoryVideo = "ui/viewres/story/storyviewvideo.prefab"
var_0_0.UrlStoryVideoCompatible = "ui/viewres/story/storyviewvideocompatible.prefab"
var_0_0.UrlNicknameVideo = "ui/viewres/login/nicknamevideo.prefab"
var_0_0.UrlNicknameVideoCompatible = "ui/viewres/login/nicknamevideocompatible.prefab"
var_0_0.URLRolesprefabDict = {
	["rolesstory/rolesprefab/305901_door_p/305901_door_p_light.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_light_compatible.prefab",
	["rolesstory/rolesprefab/305901_door_p/305901_door_p.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_compatible.prefab"
}

function var_0_0.getPreloadList()
	return {
		var_0_0.UrlVideo,
		var_0_0.UrlVideoCompatible,
		var_0_0.UrlVideoDisable
	}
end

return var_0_0
