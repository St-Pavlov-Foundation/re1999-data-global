module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeItem", package.seeall)

slot0 = class("ArmPuzzlePipeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._imageBg = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_Bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_icon")
	slot0._imagenum = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_num")
	slot0._imageconn = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_conn")
	slot0.tf = slot0._gocontent.transform

	slot0:_editableInitView()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goEffLight = gohelper.findChild(slot0.viewGO, "#go_content/eff_light")
	slot0._effLightAnimator = slot0._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot0._imageconnTrs = slot0._imageconn.transform

	slot0:_playAnim(false, nil)
	gohelper.setActive(slot0._imageBg, false)
end

function slot0.initItem(slot0, slot1)
	if not slot1 or slot1.typeId == 0 then
		gohelper.setActive(slot0._gocontent, false)

		return
	end

	gohelper.setActive(slot0._gocontent, true)

	slot2 = ArmPuzzlePipeModel.instance:isPlaceByXY(slot1.x, slot1.y)

	if slot1.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		slot3 = ArmPuzzlePipeModel.instance:isPlaceSelectXY(slot1.x, slot1.y)

		slot0:_playAnim(slot3, slot3 and "turngreen" or "turnred")
	else
		slot0:_playAnim(false, nil)
	end

	gohelper.setActive(slot0._imageBg, slot2 and slot1.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)
	UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageicon, slot1:getBackgroundRes(), true)

	slot3 = ArmPuzzlePipeEnum.resNumIcons[slot1.numIndex]

	if slot1:isEntry() then
		if slot3 then
			UISpriteSetMgr.instance:setArmPipeSprite(slot0._imagenum, slot3, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[slot1.typeId] then
		UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageconn, slot1:getConnectRes(), true)
	end

	slot5 = (ArmPuzzlePipeEnum.entryTypeColor[slot1.typeId] or ArmPuzzlePipeEnum.entryColor)[slot1.pathIndex] or ArmPuzzlePipeEnum.entryColor[0]

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagenum, slot5)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageicon, slot5)
	gohelper.setActive(slot0._imagenum, slot1:isEntry() and slot3 ~= nil)
	gohelper.setActive(slot0._imageconn, false)
	slot0:syncRotation(slot1)
end

function slot0._getEntryColor(slot0, slot1)
	slot2 = nil

	if slot1.typeId ~= ArmPuzzlePipeEnum.type.first and slot1.typeId == ArmPuzzlePipeEnum.type.last then
		-- Nothing
	end

	return slot2 or "#FFFFFF"
end

function slot0._playAnim(slot0, slot1, slot2)
	if slot0._lastEffActivie ~= slot1 then
		slot0._lastEffActivie = slot1

		gohelper.setActive(slot0._goEffLight, slot1)
	end

	if slot1 then
		if slot2 and slot0._lastEffActivie ~= slot2 then
			slot0._lastEffActivie = slot2

			slot0._effLightAnimator:Play(slot2)
		end
	else
		slot0._lastEffAnimName = nil
	end
end

function slot0.initConnectObj(slot0, slot1)
	slot2 = false

	if slot1 then
		if ArmPuzzlePipeEnum.pathConn[slot1.typeId] then
			slot2 = slot1:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == slot1.typeId then
			UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageicon, slot1:getConnectValue() >= 2 and slot1:getConnectRes() or slot1:getBackgroundRes(), true)
		end

		if slot2 then
			slot3, slot4 = slot0:_getConnectParam(slot1)

			UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageconn, ArmPuzzleHelper.getConnectRes(slot3), true)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._imageconn, ArmPuzzlePipeEnum.pathColor[slot1.connectPathIndex] or "#FFFFFF")
			transformhelper.setLocalRotation(slot0._imageconnTrs, 0, 0, slot4)
		end
	end

	gohelper.setActive(slot0._imageconn, slot2)
end

function slot0._getConnectParam(slot0, slot1)
	if ArmPuzzlePipeEnum.type.t_shape == slot1.typeId then
		slot2 = slot1:getConnectValue()

		for slot6, slot7 in pairs(ArmPuzzlePipeEnum.rotate) do
			if slot7[slot2] then
				return slot6, ArmPuzzleHelper.getRotation(slot6, slot2) - slot1:getRotation()
			end
		end
	end

	return slot1.typeId, 0
end

function slot0.syncRotation(slot0, slot1)
	if slot1 then
		transformhelper.setLocalRotation(slot0.tf, 0, 0, slot1:getRotation())
	end
end

slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armpuzzleitem.prefab"

return slot0
