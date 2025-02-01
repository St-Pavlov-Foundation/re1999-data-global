module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTalkView", package.seeall)

slot0 = class("TianShiNaNaTalkView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._rootTrans = gohelper.findChild(slot0.viewGO, "root").transform
	slot0._desc = gohelper.findChildTextMesh(slot0.viewGO, "root/Scroll View/Viewport/Content/txt_talk")
	slot0._headIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/Head/#simage_Head")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._onClickNext, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._steps = slot0.viewParam
	slot0._stepIndex = 0

	slot0:_nextStep()
end

function slot0._onClickNext(slot0)
	if #slot0._charArr > 5 and slot0._curShowCount < 5 then
		return
	end

	if slot1 == slot0._curShowCount then
		slot0:_nextStep()
	else
		slot0._curShowCount = slot1 - 1

		slot0:_showNextChar()
		TaskDispatcher.cancelTask(slot0._showNextChar, slot0)
	end
end

function slot0._nextStep(slot0)
	slot0._stepIndex = slot0._stepIndex + 1

	if not slot0._steps[slot0._stepIndex] then
		slot0:closeThis()

		return
	end

	if not TianShiNaNaEntityMgr.instance:getEntity(slot1.interactId) then
		logError("对话" .. slot1.id .. "找不到元件" .. slot1.interactId)
		slot0:closeThis()

		return
	end

	slot6 = recthelper.worldPosToAnchorPos(slot2:getWorldPos(), slot0.viewGO.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getMainCamera())

	recthelper.setAnchor(slot0._rootTrans, slot6.x, slot6.y + 180)

	slot0._curShowCount = 0
	slot0._charArr = GameUtil.getUCharArrWithoutRichTxt(slot1.content)

	if not string.nilorempty(slot1.icon) then
		slot0._curHeadIcon = slot1.icon
	end

	if slot0._curHeadIcon then
		slot0._headIcon:LoadImage(ResUrl.getHeadIconSmall(slot0._curHeadIcon))
	end

	if #slot0._charArr <= 1 then
		slot0._desc.text = ""

		recthelper.setHeight(slot0._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(slot0._showNextChar, slot0, 0.05, #slot0._charArr - 1)
	slot0:_showNextChar()
end

function slot0._showNextChar(slot0)
	slot0._curShowCount = slot0._curShowCount + 1
	slot0._desc.text = table.concat(slot0._charArr, "", 1, slot0._curShowCount)

	recthelper.setHeight(slot0._rootTrans, math.max(111, slot0._desc.preferredHeight + 40))
end

function slot0.onClose(slot0)
	slot0._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._showNextChar, slot0)
end

return slot0
