module("modules.logic.versionactivity2_3.act174.view.info.Act174RoleInfo", package.seeall)

local var_0_0 = class("Act174RoleInfo", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goRoot = gohelper.findChild(arg_5_0.viewGO, "root")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0.viewParam then
		local var_7_0 = arg_7_0.viewParam.pos or Vector2.New(0, 0)

		recthelper.setAnchor(arg_7_0.goRoot.transform, var_7_0.x, var_7_0.y)

		local var_7_1 = Activity174Config.instance:getRoleCo(arg_7_0.viewParam.roleId)

		if not arg_7_0.characterItem then
			arg_7_0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0.goRoot, Act174CharacterInfo, arg_7_0)
		end

		arg_7_0.characterItem:setData(var_7_1, arg_7_0.viewParam.itemId)
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
