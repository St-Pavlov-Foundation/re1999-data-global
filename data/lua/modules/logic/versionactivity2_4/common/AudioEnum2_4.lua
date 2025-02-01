module("modules.logic.versionactivity2_4.common.AudioEnum2_4", package.seeall)

slot0 = AudioEnum
slot0.Bakaluoer = {
	play_ui_diqiu_settle_accounts = 20240050,
	play_ui_diqiu_unlock = 20240051,
	play_ui_diqiu_count_down = 20240049
}
slot0.Act181 = {
	play_ui_diqiu_xueye_open = 20240052
}
slot2 = {}

for slot6, slot7 in pairs({}) do
	if isDebugBuild and slot0.Bgm[slot6] then
		logError("AudioEnum.Bgm重复定义" .. slot6)
	end

	slot0.Bgm[slot6] = slot7
end

for slot6, slot7 in pairs(slot2) do
	if isDebugBuild and slot0.UI[slot6] then
		logError("AudioEnum.UI重复定义" .. slot6)
	end

	slot0.UI[slot6] = slot7
end

function slot0.activate()
end

return slot0
