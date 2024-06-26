module 0x9dfb6219781bb4e390220bdb0c427f8284916c7886e193e061b847cd7dd0d4fd::MyObject {
    use std::signer;
    use aptos_framework::object;
    use aptos_framework::object::{Object,ObjectGroup};

    #[resource_grop_member(group = ObjectGroup)]
    struct MyStruct has key {
        num: u8
    }

    #[resource_grop_member(group = ObjectGroup)]
    struct YourStruct has key {
        bools: bool
    }

    #[resource_grop_member(group = ObjectGroup)]
    struct ExtendRef has key {
        extend_ref: object::ExtendRef
    }

    #[resource_grop_member(group = ObjectGroup)]
    struct TransferRef has key {
        transfer_ref: object::TransferRef
    }

    #[resource_grop_member(group = ObjectGroup)]
    struct DeleteRef has key {
        delete_ref: object::DeleteRef
    }

    // 使用entry修饰符，函数或方法可以从其他模块或外部调用
    entry fun create(caller:&signer) {
        let caller_addr = signer::address_of(caller);
        let obj_ref = object::create_object(caller_addr);
        let obj_signer = object::generate_signer(&obj_ref);

        // 扩展Ref
        let obj_extend_ref = object::generate_extend_ref(&obj_ref);
        // 转移Ref
        let obj_transfer_ref = object::generate_transfer_ref(&obj_ref);
        // 删除Ref
        let obj_delete_ref = object::generate_delete_ref(&obj_ref);

        // move_to 是在向object中添加内容
        move_to(&obj_signer, MyStruct{
            num:64
        });

        // Add 扩展Ref
        move_to(&obj_signer, ExtendRef{extend_ref:obj_extend_ref});
        // Add 转移Ref
        move_to(&obj_signer, TransferRef{transfer_ref:obj_transfer_ref});
        // Add 删除Ref
        move_to(&obj_signer, DeleteRef{delete_ref:obj_delete_ref});
    }

    entry fun add_struct(obj:Object<MyStruct>) acquires ExtendRef {
        let obj_addr = object::object_address(&obj);
        let obj_extend_ref = &borrow_global<ExtendRef>(obj_addr).extend_ref;
        let obj_signer = object::generate_signer_for_extending(obj_extend_ref);

        move_to(&obj_signer, YourStruct{
            bools: true
        })
    }

    entry fun transfer(owner:&signer, obj:Object<MyStruct>,to:address) {
        object::transfer(owner, obj, to);
    }

    entry fun switch_transfer(obj:Object<MyStruct>) acquires TransferRef {
        let obj_addr = object::object_address(&obj);
        let obj_transfer_ref = &borrow_global<TransferRef>(obj_addr).transfer_ref;
        if(object::ungated_transfer_allowed(obj)){
            object::disable_ungated_transfer(obj_transfer_ref);
        } else {
            object::enable_ungated_transfer(obj_transfer_ref);
        }
    }

    entry fun delete(owner:&signer, obj:Object<MyStruct>) acquires DeleteRef {
        let obj_addr = object::object_address(&obj);
        let DeleteRef { delete_ref } = move_from<DeleteRef>(obj_addr);

        object::delete(delete_ref);
    }

    // acquires 用于指定函数在执行期间需要获得的资源，以确保并发环境中的安全访问
    entry  fun update(caller:&signer, obj_addr:address, num:u8) acquires MyStruct{
        // borrow_global_mut 获取可变量
        let obj_ref = borrow_global_mut<MyStruct>(obj_addr);
        obj_ref.num = num;
    }

    #[view]
    public fun query(obj_addr:address):u8 acquires MyStruct {
        // borrow_global 获取不变量
        let obj_ref = borrow_global<MyStruct>(obj_addr);
        obj_ref.num
    }

    #[view]
    public fun owner(obj:Object<MyStruct>):address {
        object::owner(obj)
    }
}