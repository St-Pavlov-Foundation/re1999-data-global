module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairGameMapItem", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairGameMapItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._contentTrans = slot0._gocontent.transform
	slot0._imageBg = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_Bg")

	gohelper.setActive(slot0._imageBg, false)

	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_icon")
	slot0._goEffLight = gohelper.findChild(slot0.viewGO, "#go_content/eff_light")
	slot0._effLightAnimator = slot0._goEffLight:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot0._imageconn = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_conn")
	slot0._imageconnTrs = slot0._imageconn.transform
	slot0._imagenum = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_num")

	slot0:_playAnim(false, nil)
end

function slot0.initItem(slot0, slot1)
	if not slot1 or slot1.typeId == 0 then
		gohelper.setActive(slot0._gocontent, false)

		return
	end

	gohelper.setActive(slot0._gocontent, true)

	slot2 = Activity157RepairGameModel.instance:isPlaceByXY(slot1.x, slot1.y)

	if slot1.typeId == ArmPuzzlePipeEnum.type.zhanwei then
		slot3 = Activity157RepairGameModel.instance:isPlaceSelectXY(slot1.x, slot1.y)

		slot0:_playAnim(slot3, slot3 and "turngreen" or "turnred")
	else
		slot0:_playAnim(false, nil)
	end

	gohelper.setActive(slot0._imageBg, slot2 and slot1.typeId ~= ArmPuzzlePipeEnum.type.zhanwei)

	slot3, slot4 = slot1:getBackgroundRes()

	if slot4 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._imageicon, slot3, true)
	else
		UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageicon, slot3, true)
	end

	slot5 = ArmPuzzlePipeEnum.resNumIcons[slot1.numIndex]

	if slot1:isEntry() then
		if slot5 then
			UISpriteSetMgr.instance:setArmPipeSprite(slot0._imagenum, slot5, true)
		end
	elseif ArmPuzzlePipeEnum.pathConn[slot1.typeId] then
		slot6, slot7 = slot1:getBackgroundRes()

		if slot7 then
			UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._imageconn, slot6, true)
		else
			UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageconn, slot6, true)
		end
	end

	slot7 = (Activity157Enum.entryTypeColor[slot1.typeId] or Activity157Enum.entryColor)[slot1.pathIndex] or Activity157Enum.entryColor[0]

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagenum, slot7)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageicon, slot7)
	gohelper.setActive(slot0._imagenum, slot1:isEntry() and slot5 ~= nil)
	gohelper.setActive(slot0._imageconn, false)
	slot0:syncRotation(slot1)
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

function slot0.syncRotation(slot0, slot1)
	if not slot1 then
		return
	end

	transformhelper.setLocalRotation(slot0._contentTrans, 0, 0, slot1:getRotation())
end

function slot0.initConnectObj(slot0, slot1)
	slot2 = false

	if slot1 then
		if ArmPuzzlePipeEnum.pathConn[slot1.typeId] then
			slot2 = slot1:getConnectValue() ~= 0
		elseif ArmPuzzlePipeEnum.type.wrong == slot1.typeId then
			slot3, slot4 = nil

			if slot1:getConnectValue() >= 2 then
				slot3, slot4 = slot1:getConnectRes()
			else
				slot3, slot4 = slot1:getBackgroundRes()
			end

			if slot4 then
				UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._imageicon, slot3, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageicon, slot3, true)
			end
		end

		if slot2 then
			slot3, slot4 = slot0:_getConnectParam(slot1)
			slot5, slot6 = ArmPuzzleHelper.getConnectRes(slot3, Activity157Enum.res)

			if slot6 then
				UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._imageconn, slot5, true)
			else
				UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageconn, slot5, true)
			end

			SLFramework.UGUI.GuiHelper.SetColor(slot0._imageconn, Activity157Enum.pathColor[slot1.connectPathIndex] or "#FFFFFF")
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

function slot0.onDestroy(slot0)
end

return slot0
