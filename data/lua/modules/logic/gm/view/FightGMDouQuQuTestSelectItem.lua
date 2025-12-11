module("modules.logic.gm.view.FightGMDouQuQuTestSelectItem", package.seeall)

local var_0_0 = class("FightGMDouQuQuTestSelectItem", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnSelect = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn")
	arg_1_0._selected = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._text = gohelper.findChildText(arg_1_0.viewGO, "Text")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0._btnSelect, arg_2_0._onBtnSelect)
end

function var_0_0._onBtnSelect(arg_3_0)
	local var_3_0 = arg_3_0:getSelfIndex()

	if arg_3_0.listType == "_enemySelectedList" or arg_3_0.listType == "_playerSelectedList" then
		arg_3_0.PARENT_VIEW[arg_3_0.listType]:removeIndex(var_3_0)

		local var_3_1 = arg_3_0.listType == "_enemySelectedList" and arg_3_0.PARENT_VIEW._enemySelectList or arg_3_0.PARENT_VIEW._playerSelectList
		local var_3_2 = 0

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			if iter_3_1.config.robotId < arg_3_0.config.robotId then
				var_3_2 = var_3_2 + 1
			end
		end

		local var_3_3 = var_3_2 + 1
		local var_3_4 = var_3_1:addIndex(var_3_3, arg_3_0.config)

		gohelper.setSibling(var_3_4.GAMEOBJECT, var_3_3 - 1)
	else
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			local var_3_5 = arg_3_0.ITEM_LIST_MGR.lastSelectIndex

			if var_3_5 and var_3_5 < #arg_3_0.ITEM_LIST_MGR and var_3_5 > 0 then
				local var_3_6 = math.min(var_3_5, var_3_0)
				local var_3_7 = math.max(var_3_5, var_3_0)

				for iter_3_2 = var_3_6, var_3_7 do
					if not arg_3_0.ITEM_LIST_MGR[iter_3_2].selecting then
						arg_3_0.ITEM_LIST_MGR[iter_3_2].selecting = true

						gohelper.setActive(arg_3_0.ITEM_LIST_MGR[iter_3_2]._selected, true)
					end
				end

				arg_3_0.ITEM_LIST_MGR.lastSelectIndex = var_3_0

				return
			end
		end

		arg_3_0.selecting = not arg_3_0.selecting

		gohelper.setActive(arg_3_0._selected, arg_3_0.selecting)

		arg_3_0.ITEM_LIST_MGR.lastSelectIndex = var_3_0
	end
end

function var_0_0.onRefreshItemData(arg_4_0, arg_4_1)
	gohelper.setSibling(arg_4_0.viewGO, arg_4_0:getSelfIndex() - 1)

	arg_4_0.listType = arg_4_0.ITEM_LIST_MGR.listType
	arg_4_0.selecting = false

	gohelper.setActive(arg_4_0._selected, arg_4_0.selecting)

	arg_4_0.config = arg_4_1

	local var_4_0 = ""

	for iter_4_0 = 1, 4 do
		local var_4_1 = arg_4_1["role" .. iter_4_0]

		if var_4_1 ~= 0 then
			local var_4_2 = lua_activity174_test_role.configDict[var_4_1]

			if iter_4_0 > 1 then
				var_4_0 = var_4_0 .. "+"
			end

			if var_4_2 then
				var_4_0 = var_4_0 .. var_4_2.name
			else
				logError("测试人物表 找不到id:" .. var_4_1)
			end
		end
	end

	arg_4_0._text.text = arg_4_1.robotId .. " " .. var_4_0
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
