/*
 * Copyright (c) 2026 OpenDroidOS
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class Content<T> {
    create(): Derived<T> { return new Derived<T>(); }
    isReady(): boolean { return true; }
}

class OtherContent {
    isReady(): boolean { return true; }
}

class Derived<T> extends Base {
    apply<U = undefined>(content: Content<U> | OtherContent) {
        this.value = 3;
    }
}

class Base {
    public value: int = 0;
    enabled(): boolean { return true; }

    apply<T = undefined>(content: Content<T>) {
        if (!content.isReady()) { return; }
        if (!this.enabled()) { return; }
        this.value = 1;
    }

    apply<T = undefined>(content: Content<T> | OtherContent) {
        if (!content.isReady()) { return; }
        if (!this.enabled()) { return; }
        this.value = 2;
    }
}

function main(): void {
    let base = new Base();
    base.apply<int>(new Content<int>());
    arktest.assertEQ(base.value, 1);
    let derived = new Content<int>().create();
    derived.apply<int>(new Content<int>());
    arktest.assertEQ(derived.value, 3);
}
