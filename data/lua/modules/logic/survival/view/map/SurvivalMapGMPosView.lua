module("modules.logic.survival.view.map.SurvivalMapGMPosView", package.seeall)

local var_0_0 = class("SurvivalMapGMPosView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogm = gohelper.findChild(arg_1_0.viewGO, "#go_gmpos")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_gmpos/#go_item")
end

function var_0_0.onOpen(arg_2_0)
	if not isDebugBuild then
		return
	end

	arg_2_0._cloneItems = arg_2_0:getUserDataTb_()

	TaskDispatcher.runRepeat(arg_2_0._checkInput, arg_2_0, 0, -1)
end

function var_0_0._checkInput(arg_3_0)
	local var_3_0 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

	gohelper.setActive(arg_3_0._gogm, var_3_0)

	if var_3_0 then
		local var_3_1 = SurvivalMapModel.instance:getSceneMo()
		local var_3_2 = UnityEngine.Screen.width
		local var_3_3 = UnityEngine.Screen.height
		local var_3_4 = Vector3(var_3_2 / 2, var_3_3 / 2, 0)
		local var_3_5 = SurvivalHelper.instance:getScene3DPos(var_3_4)
		local var_3_6 = SurvivalHexNode.New(SurvivalHelper.instance:worldPointToHex(var_3_5.x, var_3_5.y, var_3_5.z))

		for iter_3_0, iter_3_1 in ipairs(SurvivalHelper.instance:getAllPointsByDis(var_3_6, 10)) do
			if not arg_3_0._cloneItems[iter_3_0] then
				local var_3_7 = gohelper.cloneInPlace(arg_3_0._goitem)

				gohelper.setActive(var_3_7, true)

				arg_3_0._cloneItems[iter_3_0] = gohelper.findChildTextMesh(var_3_7, "")
			end

			local var_3_8, var_3_9, var_3_10 = SurvivalHelper.instance:hexPointToWorldPoint(iter_3_1.q, iter_3_1.r)
			local var_3_11, var_3_12 = recthelper.worldPosToAnchorPosXYZ(var_3_8, var_3_9, var_3_10, arg_3_0._gogm.transform)

			recthelper.setAnchor(arg_3_0._cloneItems[iter_3_0].transform, var_3_11, var_3_12)

			local var_3_13 = var_3_1:getListByPos(iter_3_1)
			local var_3_14 = ""

			if var_3_13 and var_3_13[1] then
				var_3_14 = "\nid:"

				for iter_3_2 = 1, #var_3_13 do
					if iter_3_2 > 1 then
						var_3_14 = var_3_14 .. "、"
					end

					local var_3_15 = var_3_13[iter_3_2]

					var_3_14 = var_3_14 .. var_3_15.id
				end
			end

			arg_3_0._cloneItems[iter_3_0].text = string.format("[%d,%d]%s", iter_3_1.q, iter_3_1.r, var_3_14)
		end
	end
end

function var_0_0.onClose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._checkInput, arg_4_0)
end

return var_0_0
