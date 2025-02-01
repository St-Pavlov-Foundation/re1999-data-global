module("modules.ugui.UIDockingHelper", package.seeall)

slot0 = SLFramework.UGUI.RectTrHelper
slot2 = 16

return {
	__calcSudokuNilLocalPosV2 = function (slot0, slot1)
		slot2 = CameraMgr.instance:getUICamera()

		return uv0.ScreenPosToAnchorPos(slot2:WorldToScreenPoint(slot1.position), slot0.parent, slot2)
	end,
	Dock = {
		LB_RT = 10,
		RB_RT = 14,
		LB_RB = 8,
		RT_RT = 6,
		LT_LB = 1,
		LT_RB = 0,
		LT_LT = 3,
		RT_RB = 4,
		LB_LB = 9,
		RT_LB = 5,
		RB_LT = 15,
		LT_RT = 2,
		RB_LB = 13,
		RB_RB = 12,
		LB_LT = 11,
		RT_LT = 7,
		LT_U = 0 + slot2,
		MT_U = 3 + slot2,
		RT_U = 6 + slot2,
		LT_M = 1 + slot2,
		MT_M = 3 + slot2,
		RT_M = 7 + slot2,
		LT_D = 2 + slot2,
		MT_D = 5 + slot2,
		RT_D = 8 + slot2,
		ML_L = 9 + slot2,
		ML_M = 10 + slot2,
		ML_R = 11 + slot2,
		MR_L = 12 + slot2,
		MR_M = 13 + slot2,
		MR_R = 14 + slot2,
		LB_U = 15 + slot2,
		MB_U = 18 + slot2,
		RB_U = 21 + slot2,
		LB_M = 16 + slot2,
		MB_M = 19 + slot2,
		RB_M = 22 + slot2,
		LB_D = 17 + slot2,
		MB_D = 20 + slot2,
		RB_D = 23 + slot2
	},
	_calcDockSudokuLocalPosV2 = function (slot0, slot1, slot2)
		if not slot0 then
			return uv0.__calcSudokuNilLocalPosV2(slot1, slot2)
		end

		slot8 = slot2.rect
		slot11 = slot1.rect
		slot12 = slot11.width * 0.5

		if math.modf(slot0 / 3) <= 2 then
			slot5 = 0 + slot8.height * 0.5 - slot11.height * 0.5 * (slot0 % 3 - 1)
			slot4 = 0 + slot8.width * 0.5 * (slot6 - 1)
		elseif slot6 <= 4 then
			slot4 = slot4 + slot9 * (slot6 * 2 - 7) + slot12 * slot7
		else
			slot5 = slot5 - slot10 - slot13 * slot7
			slot4 = slot4 + slot9 * (slot6 - 6)
		end

		slot3.x = slot3.x + slot4
		slot3.y = slot3.y + slot5

		return slot3
	end,
	_calcDockCornorLocalPosV2 = function (slot0, slot1, slot2)
		if not slot0 then
			return uv0.__calcSudokuNilLocalPosV2(slot1, slot2)
		end

		slot7 = slot0 % 4
		slot8 = slot2.rect

		if math.modf(slot0 / 4) == 0 then
			slot4 = 0 - slot8.width * 0.5
			slot5 = 0 + slot8.height * 0.5
		elseif slot6 == 1 then
			slot4 = slot4 + slot9
			slot5 = slot5 + slot10
		elseif slot6 == 2 then
			slot4 = slot4 - slot9
			slot5 = slot5 - slot10
		elseif slot6 == 3 then
			slot4 = slot4 + slot9
			slot5 = slot5 - slot10
		end

		slot11 = slot1.rect

		if slot7 == 0 then
			slot4 = slot4 + slot11.width * 0.5
			slot5 = slot5 - slot11.height * 0.5
		elseif slot7 == 1 then
			slot4 = slot4 - slot12
			slot5 = slot5 - slot13
		elseif slot7 == 2 then
			slot4 = slot4 + slot12
			slot5 = slot5 + slot13
		elseif slot7 == 3 then
			slot4 = slot4 - slot12
			slot5 = slot5 + slot13
		end

		slot3.x = slot3.x + slot4
		slot3.y = slot3.y + slot5

		return slot3
	end,
	calcDockLocalPosV2 = function (slot0, slot1, slot2)
		if not slot0 then
			return uv0.__calcSudokuNilLocalPosV2(slot1, slot2)
		end

		assert(slot0 >= 0 and slot0 <= 23 + uv1, "eDock=" .. tostring(slot0))

		if uv1 <= slot0 then
			return uv0._calcDockSudokuLocalPosV2(slot0 - uv1, slot1, slot2)
		else
			return uv0._calcDockCornorLocalPosV2(slot0, slot1, slot2)
		end
	end,
	setDock = function (slot0, slot1, slot2, slot3, slot4)
		transformhelper.setLocalPos(slot1, uv0.calcDockLocalPosV2(slot0 or uv0.Dock.MM_M, slot1, slot2).x + (slot3 or 0), slot5.y + (slot4 or 0), 0)
	end
}
