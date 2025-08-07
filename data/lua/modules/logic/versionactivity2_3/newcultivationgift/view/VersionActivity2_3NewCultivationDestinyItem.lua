module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDestinyItem", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationDestinyItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._simagestone = gohelper.findChildSingleImage(arg_1_1, "#simage_stone")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_1, "title/#txt_title")
	arg_1_0._goNewTag = gohelper.findChild(arg_1_1, "title/#go_NewTag")
	arg_1_0._godecitem = gohelper.findChild(arg_1_1, "#go_decitem")
	arg_1_0._descItemList = {}
	arg_1_0._descCompList = {}
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._destinyId = arg_2_2
	arg_2_0._roleId = arg_2_1

	arg_2_0:refreshUI(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._go, arg_3_1)
end

function var_0_0.refreshUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	gohelper.setActive(arg_4_0._goNewTag, arg_4_3 or false)

	local var_4_0 = CharacterDestinyConfig.instance:getDestinyFacetCo(arg_4_2)
	local var_4_1 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_4_2)

	arg_4_0._txttitle.text = var_4_1.name

	arg_4_0._simagestone:LoadImage(ResUrl.getDestinyIcon(var_4_1.icon))

	local var_4_2 = 0
	local var_4_3 = #arg_4_0._descItemList

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		var_4_2 = var_4_2 + 1

		local var_4_4
		local var_4_5

		if var_4_3 < var_4_2 then
			local var_4_6 = gohelper.clone(arg_4_0._godecitem, arg_4_0._go)

			gohelper.setActive(var_4_6, true)

			var_4_4 = gohelper.findChildTextMesh(var_4_6, "#txt_dec")

			gohelper.setAsLastSibling(var_4_6)

			var_4_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_4.gameObject, SkillDescComp)

			table.insert(arg_4_0._descItemList, var_4_4)
			table.insert(arg_4_0._descCompList, var_4_5)
		else
			var_4_4 = arg_4_0._descItemList[var_4_2]
			var_4_5 = arg_4_0._descCompList[var_4_2]
		end

		gohelper.setActive(var_4_4.transform.parent.gameObject, true)
		var_4_5:updateInfo(var_4_4, iter_4_1.desc, arg_4_1)
		var_4_5:setTipParam(0, Vector2(380, 100))
	end

	if var_4_2 < var_4_3 then
		for iter_4_2 = var_4_2 + 1, var_4_3 do
			local var_4_7 = arg_4_0._descItemList[iter_4_2]

			gohelper.setActive(var_4_7.transform.parent.gameObject, false)
		end
	end
end

function var_0_0.onDestroy(arg_5_0)
	if not arg_5_0._isDisposed then
		arg_5_0._isDisposed = true
	end
end

return var_0_0
