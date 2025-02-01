module("modules.common.others.LuaListScrollExtend", package.seeall)

slot0 = class("LuaListScrollExtend", LuaListScrollView)

function slot0.onUpdateFinish(slot0)
	for slot4, slot5 in pairs(slot0._cellCompDict) do
		slot4.parent_view = slot0

		if slot4.initDone then
			slot4:initDone()
		end
	end

	slot0.isInitDone = true
end

return slot0
