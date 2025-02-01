module("modules.common.utils.CommonJumpUtil", package.seeall)

slot0 = _M

function slot0._enterMainScene(slot0)
	logError("enter main scene " .. cjson.encode(slot0))
end

function slot0._jumpSpecial(slot0)
	logError("jump special " .. cjson.encode(slot0))
end

function slot0._openSpecialView(slot0)
	logError("open special view " .. cjson.encode(slot0))
end

slot0.JumpTypeSpecialFunc = {
	special = slot0._jumpSpecial
}
slot0.JumpViewSpecialFunc = {
	["view#special"] = slot0._openSpecialView
}
slot0.JumpSceneFunc = {
	["scene#main"] = slot0._enterMainScene
}
slot0.JumpSeparator = "#"
slot0.JumpType = {
	View = "view",
	Scene = "scene"
}

function slot0.jump(slot0)
	if string.nilorempty(slot0) then
		return
	end

	if uv0.JumpTypeSpecialFunc[string.trim(string.split(slot0, uv0.JumpSeparator)[1])] then
		slot3(uv0._deserializeParams(slot1, 2))
	elseif slot2 == uv0.JumpType.View then
		if uv0.JumpViewSpecialFunc[uv0.JumpType.View .. uv0.JumpSeparator .. string.trim(slot1[2])] then
			slot7(uv0._deserializeParams(slot1, 3))
		else
			ViewMgr.instance:openView(slot5, slot4)
		end
	elseif slot2 == uv0.JumpType.Scene then
		if uv0.JumpSceneFunc[uv0.JumpType.Scene .. uv0.JumpSeparator .. string.trim(slot1[2])] then
			slot6(uv0._deserializeParams(slot1, 3))
		else
			logError("jumpType scene invalid: " .. slot0)
		end
	else
		logError("jumpType invalid: " .. slot0)
	end
end

function slot0._deserializeParams(slot0, slot1)
	if slot1 > #slot0 then
		return nil
	end

	slot3 = slot0[slot2]

	if slot1 < slot2 then
		slot4 = {}

		for slot8 = slot1, slot2 do
			table.insert(slot4, slot0[slot8])
		end

		slot3 = table.concat(slot4, uv0.JumpSeparator)
	end

	return cjson.decode(slot3)
end

return slot0
