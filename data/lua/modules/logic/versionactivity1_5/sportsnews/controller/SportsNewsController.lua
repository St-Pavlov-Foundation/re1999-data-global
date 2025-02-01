module("modules.logic.versionactivity1_5.sportsnews.controller.SportsNewsController", package.seeall)

slot0 = class("SportsNewsController", BaseController)

function slot0.openSportsNewsMainView(slot0, slot1)
	SportsNewsModel.instance:setJumpToOrderId(nil)
	ViewMgr.instance:openView(ViewName.SportsNewsView, {
		formToMain = true,
		actId = slot1 or VersionActivity1_5Enum.ActivityId.SportsNews
	})
end

slot0.UI_CLICK_BLOCK_KEY = "SportsNewsBlock"

function slot0.startBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0.endBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.cantJumpDungeonGetName(slot0, slot1)
	if not JumpConfig.instance:getJumpConfig(slot1) then
		return false
	end

	slot4, slot5 = JumpController.instance:canJumpNew(slot2.param)

	if slot4 then
		return true
	end

	slot6 = string.split(slot3, "#")

	if DungeonConfig.instance:getEpisodeCO(tonumber(slot6[#slot6])) then
		return false, ToastEnum.V1a5SportNewsOrderJumpTo, DungeonController.getEpisodeName(slot8), slot8.name
	end

	return false, slot5
end

function slot0.jumpToFinishTask(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = slot0:cantJumpDungeonGetName(slot1.cfg.jumpId)

	if not slot4 then
		GameFacade.showToast(slot5, slot6, slot7)
	else
		SportsNewsModel.instance:setJumpToOrderId(slot1.cfg.id)
		JumpController.instance:jump(slot1.cfg.jumpId, slot2, slot3, {
			special = true,
			desc = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_news_order_return_view"), {
				luaLang("p_versionactivity_1_5_enterview_txt_Activity2"),
				slot1.cfg.name
			}),
			checkFunc = slot1.canFinish,
			checkFuncObj = slot1,
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		})
	end
end

slot0.instance = slot0.New()

return slot0
