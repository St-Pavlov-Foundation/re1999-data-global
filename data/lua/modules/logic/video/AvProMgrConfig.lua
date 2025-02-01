module("modules.logic.video.AvProMgrConfig", package.seeall)

slot0 = _M
slot0.UrlVideo = "ui/viewres/video/videoplayer.prefab"
slot0.UrlVideoCompatible = "ui/viewres/video/videocompatible.prefab"
slot0.UrlVideoDisable = "ui/viewres/video/videodisable.prefab"
slot0.UrlFightVideo = "ui/viewres/fight/fightvideo.prefab"
slot0.UrlFightVideoCompatible = "ui/viewres/fight/fightvideocompatible.prefab"
slot0.UrlStoryVideo = "ui/viewres/story/storyviewvideo.prefab"
slot0.UrlStoryVideoCompatible = "ui/viewres/story/storyviewvideocompatible.prefab"
slot0.UrlNicknameVideo = "ui/viewres/login/nicknamevideo.prefab"
slot0.UrlNicknameVideoCompatible = "ui/viewres/login/nicknamevideocompatible.prefab"
slot0.URLRolesprefabDict = {
	["rolesstory/rolesprefab/305901_door_p/305901_door_p_light.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_light_compatible.prefab",
	["rolesstory/rolesprefab/305901_door_p/305901_door_p.prefab"] = "rolesstory/rolesprefab/305901_door_p/305901_door_p_compatible.prefab"
}

function slot0.getPreloadList()
	return {
		uv0.UrlVideo,
		uv0.UrlVideoCompatible,
		uv0.UrlVideoDisable
	}
end

return slot0
