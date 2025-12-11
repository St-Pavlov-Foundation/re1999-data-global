module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem1", package.seeall)

local var_0_0 = class("Act191HeroGroupItem1", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goEmpty = gohelper.findChild(arg_1_1, "go_Empty")
	arg_1_0.goHero = gohelper.findChild(arg_1_1, "go_Hero")
	arg_1_0.btnClick = gohelper.findChildButton(arg_1_1, "btn_Click")
	arg_1_0.loader = PrefabInstantiate.Create(arg_1_0.goHero)

	arg_1_0.loader:startLoad(Activity191Enum.PrefabPath.HeroHeadItem, arg_1_0.onLoadCallBack, arg_1_0)

	arg_1_0.enableClick = true
	arg_1_0.dragging = false
end

function var_0_0.onLoadCallBack(arg_2_0)
	local var_2_0 = arg_2_0.loader:getInstGO()

	if var_2_0 then
		arg_2_0.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_0, Act191HeroHeadItem, {
			exSkill = true
		})

		if arg_2_0.needFresh then
			arg_2_0.heroHeadItem:setData(arg_2_0.heroId)

			arg_2_0.needFresh = false
		end
	end
end

function var_0_0.addEventListeners(arg_3_0)
	if arg_3_0.btnClick then
		arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
	end
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.heroId = arg_4_1

	if arg_4_1 and arg_4_1 ~= 0 then
		if arg_4_0.heroHeadItem then
			arg_4_0.heroHeadItem:setData(arg_4_1)

			arg_4_0.needFresh = false
		else
			arg_4_0.needFresh = true
		end

		gohelper.setActive(arg_4_0.goEmpty, false)
		gohelper.setActive(arg_4_0.goHero, true)
	else
		gohelper.setActive(arg_4_0.goEmpty, true)
		gohelper.setActive(arg_4_0.goHero, false)
	end
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0._index = arg_5_1
end

function var_0_0.setClickEnable(arg_6_0, arg_6_1)
	arg_6_0.enableClick = arg_6_1
end

function var_0_0.onClick(arg_7_0)
	if not arg_7_0.enableClick or arg_7_0.dragging then
		return
	end

	if arg_7_0.param then
		local var_7_0 = ""

		if arg_7_0.heroHeadItem and arg_7_0.heroHeadItem.config then
			var_7_0 = arg_7_0.heroHeadItem.config.name
		end

		Act191StatController.instance:statButtonClick(arg_7_0.param.fromView, string.format("heroClick_%s_%s_%s", arg_7_0.param.type, arg_7_0._index, var_7_0))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_7_1 = {
		index = arg_7_0._index,
		heroId = arg_7_0.heroId
	}

	ViewMgr.instance:openView(ViewName.Act191HeroEditView, var_7_1)
end

function var_0_0.setExtraParam(arg_8_0, arg_8_1)
	arg_8_0.param = arg_8_1
end

function var_0_0.setDrag(arg_9_0, arg_9_1)
	arg_9_0.dragging = arg_9_1
end

return var_0_0
