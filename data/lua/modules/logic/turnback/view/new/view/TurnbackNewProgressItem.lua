module("modules.logic.turnback.view.new.view.TurnbackNewProgressItem", package.seeall)

slot0 = class("TurnbackNewProgressItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0.index == 1 or slot0._isJump == true then
		slot0._btnactivity:RemoveClickListener()
	end
end

function slot0.initItem(slot0, slot1)
	slot0.index = slot1

	if slot0.index == 1 then
		slot0:initMainActivity()
	else
		slot0:initNormalItem()
	end
end

function slot0.initMainActivity(slot0)
	slot0._btnactivity = gohelper.findChildButton(slot0.go, "#btn_activity")

	slot0._btnactivity:AddClickListener(slot0._onClickMainActivity, slot0)

	slot0.txttitle = gohelper.findChildText(slot0.go, "titlebg/#txt_title")
	slot0.txttitle.text = TurnbackConfig.instance:getDropCoById(1).name
end

function slot0.initNormalItem(slot0)
	slot0.goprogress = gohelper.findChild(slot0.go, "progress")
	slot0.gounfinish = gohelper.findChild(slot0.go, "progress/unfinish")
	slot0.txtunfinish = gohelper.findChildText(slot0.go, "progress/unfinish/#txt_progress")
	slot0.imgunfinish = gohelper.findChildImage(slot0.go, "progress/unfinish/bg/fill")
	slot0.gofinished = gohelper.findChild(slot0.go, "progress/finished")
	slot0.simagepic = gohelper.findChildSingleImage(slot0.go, "#simage_pic")
	slot0._btnactivity = gohelper.findChildButton(slot0.go, "#btn_activity")
	slot0._gojumpicon = gohelper.findChild(slot0.go, "icon")
end

function slot0._onClickMainActivity(slot0)
	_G[string.format("VersionActivity%sEnterController", ActivityHelper.getActivityVersion(ActivityEnum.VersionActivityIdList[#ActivityEnum.VersionActivityIdList]))]:openVersionActivityEnterView()
end

function slot0.refreshItem(slot0, slot1)
	slot0.mo = slot1
	slot0.config = slot0.mo.co
	slot0._isJump = false

	slot0.simagepic:LoadImage(ResUrl.getTurnbackIcon("new/progress/" .. slot0.config.picPath))

	slot0.txttitle = gohelper.findChildText(slot0.go, "titlebg/#txt_title")
	slot0.txttitle.text = slot0.config.name

	gohelper.setActive(slot0._btnactivity.gameObject, not string.nilorempty(slot0.config.jumpId))
	gohelper.setActive(slot0._gojumpicon, slot0.config.type == TurnbackEnum.DropType.Jump)
	gohelper.setActive(slot0.goprogress, slot0.config.type == TurnbackEnum.DropType.Progress)

	if slot2 then
		slot0._btnactivity:AddClickListener(slot0._btnclickOnClick, slot0)

		slot0._isJump = true
	end

	if slot0.config.type == TurnbackEnum.DropType.Progress then
		slot3 = slot0.mo and slot0.mo.progress and slot0.mo.progress < 1

		gohelper.setActive(slot0.gounfinish, slot3)
		gohelper.setActive(slot0.gofinished, not slot3)

		if slot3 then
			slot0.txtunfinish.text = math.floor(slot0.mo.progress * 100) / 100 * 100 .. "%"
			slot0.imgunfinish.fillAmount = slot0.mo.progress
		end
	end
end

function slot0.refreshItemBySelf(slot0)
	if slot0.index > 1 and TurnbackModel.instance:getDropInfoByType(slot0.config.id) then
		slot0:refreshItem(slot1)
	end
end

function slot0._btnclickOnClick(slot0)
	TurnbackRpc.instance:sendFinishReadTaskRequest(TurnbackEnum.ReadTaskId)
	StatController.instance:track(StatEnum.EventName.ReflowActivityJump, {
		[StatEnum.EventProperties.TurnbackJumpName] = slot0.config.name,
		[StatEnum.EventProperties.TurnbackJumpId] = tostring(slot0.config.id)
	})
	GameFacade.jump(slot0.config.jumpId)
end

function slot0.onDestroy(slot0)
end

return slot0
