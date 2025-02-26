module("modules.logic.rouge.view.comp.RougeCapacityComp", package.seeall)

slot0 = class("RougeCapacityComp", LuaCompBase)
slot0.SpriteType1 = "rouge_team_volume_1"
slot0.SpriteType2 = "rouge_team_volume_2"
slot0.SpriteType3 = "rouge_team_volume_3"

function slot0.init(slot0, slot1)
	slot0._go = slot1
end

function slot0.Add(slot0, slot1, slot2, slot3, slot4)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)

	slot5:setCurNum(slot1)
	slot5:setMaxNum(slot2)

	if slot3 then
		slot5:autoFindNodes()
	end

	slot5:setSpriteType(nil, slot4)
	slot5:initCapacity()

	return slot5
end

function slot0.getCurNum(slot0)
	return slot0._curNum
end

function slot0.getMaxNum(slot0)
	return slot0._maxNum
end

function slot0.updateCurAndMaxNum(slot0, slot1, slot2)
	slot0._curNum = slot1
	slot0._maxNum = slot2

	slot0:_refreshImageList()
end

function slot0.updateCurNum(slot0, slot1)
	slot0._curNum = slot1

	slot0:_refreshImageList()
end

function slot0.updateMaxNum(slot0, slot1)
	slot0._maxNum = slot1

	slot0:_refreshImageList()
end

function slot0.updateMaxNumAndOpaqueNum(slot0, slot1, slot2)
	slot0._opaqueNum = slot2

	slot0:updateMaxNum(slot1)
end

function slot0.showChangeEffect(slot0, slot1)
	slot0._showChangeEffect = slot1
end

function slot0.setPoint(slot0, slot1)
	slot0._pointGo = slot1
end

function slot0.setTxt(slot0, slot1)
	slot0._txt = slot1
end

function slot0.autoFindNodes(slot0)
	slot0._pointGo = gohelper.findChild(slot0._go, "point")

	gohelper.setActive(slot0._pointGo, false)

	slot0._txt = gohelper.findChildText(slot0._go, "#txt_num")

	if not slot0._pointGo then
		logError("RougeCapacityComp autoFindNodes 请检查脚本是否attach在volume上，以及节点目录是否正确")
	end
end

function slot0.setCurNum(slot0, slot1)
	if slot0._curNum then
		return
	end

	slot0._curNum = slot1
end

function slot0.setMaxNum(slot0, slot1)
	if slot0._maxNum then
		return
	end

	slot0._maxNum = slot1
end

function slot0.setSpriteType(slot0, slot1, slot2)
	slot0._usedSpriteType = slot1
	slot0._notUsedSpriteType = slot2
end

function slot0.getUsedSpriteType(slot0)
	slot0._usedSpriteType = slot0._usedSpriteType or uv0.SpriteType3

	return slot0._usedSpriteType
end

function slot0.getNotUsedSpriteType(slot0)
	slot0._notUsedSpriteType = slot0._notUsedSpriteType or uv0.SpriteType1

	return slot0._notUsedSpriteType
end

function slot0.setTxtFormat(slot0, slot1, slot2)
	slot0._notFullFormat = slot1
	slot0._fullFormat = slot2
end

function slot0.getFullFormat(slot0)
	slot0._fullFormat = slot0._fullFormat or "<#D97373>%s</color>/%s"

	return slot0._fullFormat
end

function slot0.getNotFullFormat(slot0)
	slot0._notFullFormat = slot0._notFullFormat or "<#E99B56>%s</color>/%s"

	return slot0._notFullFormat
end

function slot0.initCapacity(slot0)
	if slot0._imageList then
		return
	end

	slot0._imageList = slot0:getUserDataTb_()

	slot0:_refreshImageList()
end

function slot0._getPointInfo(slot0, slot1)
	if not slot0._imageList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._pointGo)

		gohelper.setActive(slot3, true)

		slot2 = slot0:getUserDataTb_()
		slot0._imageList[slot1] = slot2
		slot2.image = slot3:GetComponent(gohelper.Type_Image)
		slot2.yellow = gohelper.findChild(slot3, "yellow")
	end

	return slot2
end

function slot0._refreshImageList(slot0)
	if not slot0._imageList or not slot0._maxNum then
		return
	end

	slot1 = false
	slot2 = slot0._curNum or 0
	slot0._prevNum = slot2
	slot5 = slot0._opaqueNum or slot0._maxNum

	for slot9 = 1, math.max(slot4, #slot0._imageList) do
		slot12 = slot9 <= slot0._maxNum

		gohelper.setActive(slot0:_getPointInfo(slot9).image, slot12)

		if slot12 then
			if slot9 <= slot2 and slot0._showChangeEffect and slot2 ~= slot0._prevNum then
				gohelper.setActive(slot10.yellow, false)
				gohelper.setActive(slot10.yellow, true)

				slot1 = true
			end

			UISpriteSetMgr.instance:setRougeSprite(slot11, slot13 and slot0:getUsedSpriteType() or slot0:getNotUsedSpriteType())

			if slot0._opaqueNum ~= nil then
				slot14 = slot11.color
				slot14.a = slot9 <= slot5 and 1 or 0.4
				slot11.color = slot14
			end
		end
	end

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.PointLight)
	end

	if slot0._txt then
		slot0._txt.text = string.format(slot0._maxNum <= slot2 and slot0:getFullFormat() or slot0:getNotFullFormat(), slot2, slot0._maxNum)
	end
end

return slot0
