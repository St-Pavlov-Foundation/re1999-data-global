module("modules.logic.notice.model.NoticeType", package.seeall)

slot0 = _M
slot0.All = 0
slot0.Activity = 1
slot0.Game = 2
slot0.System = 3
slot0.Playing = 4
slot0.BeforeLogin = 5
slot0.Information = 6
slot0.NoticeList = {
	slot0.Activity,
	slot0.Game,
	slot0.System,
	slot0.Information
}

function slot0.getTypeIndex(slot0)
	for slot4, slot5 in ipairs(uv0.NoticeList) do
		if slot0 == slot5 then
			return slot4
		end
	end

	return 1
end

return slot0
