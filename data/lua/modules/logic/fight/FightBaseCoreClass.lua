module("modules.logic.fight.FightBaseCoreClass", package.seeall)

slot0 = class("FightBaseCoreClass")

function slot0.onConstructor(slot0)
	slot0.INSTANTIATE_CLASS_LIST = {}
	slot0.COMPONENT_LIST = {}
end

function slot0.onAwake(slot0, ...)
end

function slot0.releaseSelf(slot0)
end

function slot0.onDestructor(slot0)
	slot0:disposeClassList(slot0.COMPONENT_LIST)

	slot0.INSTANTIATE_CLASS_LIST = nil
	slot0.COMPONENT_LIST = nil
end

function slot0.onDestructorFinish(slot0)
end

function slot0.newClass(slot0, slot1, ...)
	if slot0.IS_DISPOSED or slot0.IS_RELEASING then
		logError("生命周期已经结束了,但是又调用注册类的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot2 = slot1.New(...)
	slot2.PARENT_ROOT_CLASS = slot0

	table.insert(slot0.INSTANTIATE_CLASS_LIST, slot2)

	return slot2
end

function slot0.addComponent(slot0, slot1)
	if slot0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了添加组件的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot2 = slot1.New()
	slot2.PARENT_ROOT_CLASS = slot0

	table.insert(slot0.COMPONENT_LIST, slot2)

	return slot2
end

function slot0.removeComponent(slot0, slot1)
	if not slot1 then
		return
	end

	slot1:disposeSelf()
end

function slot0.disposeSelf(slot0)
	if slot0.IS_DISPOSED then
		return
	end

	slot0.IS_DISPOSED = true

	xpcall(slot0.disposeSelfInternal, __G__TRACKBACK__, slot0)

	if slot0.keyword_gameObject then
		gohelper.destroy(slot1)
	end
end

function slot0.ctor(slot0, ...)
	slot0:initializationInternal(slot0.class, slot0, ...)

	return slot0:onAwake(...)
end

function slot0.initializationInternal(slot0, slot1, slot2, ...)
	if slot1.super then
		slot0:initializationInternal(slot3, slot2, ...)
	end

	if rawget(slot1, "onConstructor") then
		return slot4(slot2, ...)
	end
end

function slot0.disposeSelfInternal(slot0)
	if not slot0.IS_RELEASING then
		if slot0.PARENT_ROOT_CLASS then
			slot0.PARENT_ROOT_CLASS:clearDeadInstantiatedClass()
		end

		slot0:markReleasing()
		slot0:releaseChildRoot()
	end

	slot0:releaseSelf()
	slot0:destructorInternal(slot0.class, slot0)

	return slot0:onDestructorFinish()
end

function slot0.clearDeadInstantiatedClass(slot0)
	if slot0.IS_DISPOSED then
		return
	end

	if slot0.CLEARTIMER then
		return
	end

	slot0.CLEARTIMER = slot0:com_registRepeatTimer(slot0.internalClearDeadInstantiatedClass, 1, 1)
end

function slot0.internalClearDeadInstantiatedClass(slot0)
	if slot0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了清除已经死亡的类的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot0.CLEARTIMER = nil

	for slot4 = #slot0.INSTANTIATE_CLASS_LIST, 1, -1 do
		if slot0.INSTANTIATE_CLASS_LIST[slot4].IS_DISPOSED then
			table.remove(slot0.INSTANTIATE_CLASS_LIST, slot4)
		end
	end
end

function slot0.markReleasing(slot0)
	slot1 = slot0

	while slot1 do
		slot2 = slot1.INSTANTIATE_CLASS_LIST

		if not slot1.IS_RELEASING then
			slot1.IS_RELEASING = 0
		end

		if not slot2[slot1.IS_RELEASING + 1] then
			if slot1 == slot0 then
				return
			end

			slot1 = slot1.PARENT_ROOT_CLASS
		else
			slot1.IS_RELEASING = slot3

			if not slot4.IS_RELEASING then
				slot1 = slot4
			end
		end
	end
end

function slot0.releaseChildRoot(slot0)
	slot1 = slot0

	while slot1 do
		slot2 = slot1.INSTANTIATE_CLASS_LIST

		if not slot1.DISPOSEINDEX then
			slot1.DISPOSEINDEX = #slot2 + 1
		end

		if not slot2[slot1.DISPOSEINDEX - 1] then
			if slot1 == slot0 then
				return
			end

			if not slot1.IS_DISPOSED then
				slot1:disposeSelf()
			end

			slot1 = slot1.PARENT_ROOT_CLASS
		else
			slot1.DISPOSEINDEX = slot3

			if not slot4.DISPOSEINDEX then
				slot1 = slot4
			end
		end
	end
end

function slot0.destructorInternal(slot0, slot1, slot2)
	if rawget(slot1, "onDestructor") then
		slot3(slot2)
	end

	if slot1.super then
		return slot0:destructorInternal(slot4, slot2)
	end
end

function slot0.disposeClassList(slot0, slot1)
	for slot5 = #slot1, 1, -1 do
		if not slot1[slot5].IS_DISPOSED then
			slot6:disposeSelf()
		end
	end
end

return slot0
