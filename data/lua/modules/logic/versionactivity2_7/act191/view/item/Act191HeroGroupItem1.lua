module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem1", package.seeall)

local var_0_0 = class("Act191HeroGroupItem1", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handleView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goEmpty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0.goHero = gohelper.findChild(arg_2_1, "go_Hero")
	arg_2_0.btnClick = gohelper.findChildButton(arg_2_1, "btn_Click")
	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goHero)

	arg_2_0.loader:startLoad(Activity191Enum.PrefabPath.HeroHeadItem, arg_2_0.onLoadCallBack, arg_2_0)

	arg_2_0.enableClick = true
end

function var_0_0.onLoadCallBack(arg_3_0)
	local var_3_0 = arg_3_0.loader:getInstGO()

	if var_3_0 then
		arg_3_0.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, Act191HeroHeadItem, {
			exSkill = true
		})

		if arg_3_0.needFresh then
			arg_3_0.heroHeadItem:setData(arg_3_0.heroId)

			arg_3_0.needFresh = false
		end
	end
end

function var_0_0.addEventListeners(arg_4_0)
	if arg_4_0.btnClick then
		arg_4_0:addClickCb(arg_4_0.btnClick, arg_4_0.onClick, arg_4_0)
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0.heroId = arg_5_1

	if arg_5_1 and arg_5_1 ~= 0 then
		if arg_5_0.heroHeadItem then
			arg_5_0.heroHeadItem:setData(arg_5_1)

			arg_5_0.needFresh = false
		else
			arg_5_0.needFresh = true
		end

		gohelper.setActive(arg_5_0.goEmpty, false)
		gohelper.setActive(arg_5_0.goHero, true)
	else
		gohelper.setActive(arg_5_0.goEmpty, true)
		gohelper.setActive(arg_5_0.goHero, false)
	end
end

function var_0_0.setIndex(arg_6_0, arg_6_1)
	arg_6_0._index = arg_6_1
end

function var_0_0.setClickEnable(arg_7_0, arg_7_1)
	arg_7_0.enableClick = arg_7_1
end

function var_0_0.onClick(arg_8_0)
	if not arg_8_0.enableClick or arg_8_0.handleView and arg_8_0.handleView._nowDragingIndex then
		return
	end

	if arg_8_0.param then
		local var_8_0 = ""

		if arg_8_0.heroHeadItem and arg_8_0.heroHeadItem.config then
			var_8_0 = arg_8_0.heroHeadItem.config.name
		end

		Act191StatController.instance:statButtonClick(arg_8_0.param.fromView, string.format("heroClick_%s_%s_%s", arg_8_0.param.type, arg_8_0._index, var_8_0))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_8_1 = {
		index = arg_8_0._index,
		heroId = arg_8_0.heroId
	}

	ViewMgr.instance:openView(ViewName.Act191HeroEditView, var_8_1)
end

function var_0_0.setExtraParam(arg_9_0, arg_9_1)
	arg_9_0.param = arg_9_1
end

return var_0_0
