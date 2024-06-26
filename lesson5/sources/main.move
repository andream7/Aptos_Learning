module 0x42::Demo{
    use std::debug;
    use std::vector;

    #[test]
    fun test_push_back(){
        let vec = vector[1, 2, 3];
        // push_back 尾部添加1个元素
        vector::push_back(&mut vec, 4);
        debug::print(&vec);
    }

    #[test]
    fun test_append(){
        let vec1 = vector[1, 2, 3];
        let vec2 = vector[4, 5, 6];
        // append 尾部添加1个数组
        vector::append(&mut vec1, vec2);
        debug::print(&vec1);
    }

    #[test]
    fun test_reverse_append(){
        let vec1 = vector[1, 2, 3];
        let vec2 = vector[4, 5, 6];
        // 尾部添加 1个数组并排序
        vector::reverse_append(&mut vec1, vec2);
        debug::print(&vec1);
    }

    #[test]
    fun test_pop_back(){
        let vec = vector[1, 2, 3];
        // 删除尾部1个元素
        let x = vector::pop_back(&mut vec);
        debug::print(&vec);
        debug::print(&x);
    }

    #[test]
    fun test_swap(){
        let vec1 = vector[1, 2, 3,4,5];
        vector::swap(&mut vec1,0,2);
        debug::print(&vec1);
    }

    #[test]
    fun test_reverse(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        vector::reverse(&mut vec1);
        debug::print(&vec1);
    }

    #[test]
    fun test_insert(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        vector::insert(&mut vec1, 2, 10);
        debug::print(&vec1);
    }

    #[test]
    fun test_remove(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        vector::remove(&mut vec1, 2);
        debug::print(&vec1);
    }

    #[test]
    fun test_swap_remove(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        // 将第2个元素和最后一个元素互换位置
        vector::swap_remove(&mut vec1, 2);
        debug::print(&vec1);
    }

    #[test]
    fun test_trim(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        // 裁剪数组长度
        let vec2 = vector::trim(&mut vec1, 2);
        debug::print(&vec1);
        debug::print(&vec2);
    }

    #[test]
    fun test_trim_reverse(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        let vec2 = vector::trim_reverse(&mut vec1, 2);
        debug::print(&vec1);
        debug::print(&vec2);
    }

    #[test]
    fun test_rotate(){
        let vec1 = vector[1, 2, 3,4,3,2,5];
        vector::rotate(&mut vec1, 2);
        debug::print(&vec1);
    }
}