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

enum Strategy { NONE, FOLLOW }

class Options {
    strategy?: Strategy;
    selection: Strategy | int = Strategy.NONE;
}

function selected(options?: Options): int {
    if (options !== undefined && options.strategy !== undefined) {
        return (options.strategy as Strategy).valueOf();
    }
    return -1;
}

function selectedUnion(options?: Options): int {
    if (options !== undefined) {
        return options.selection as int;
    }
    return -1;
}

function main(): void {
    let options = new Options();
    arktest.assertEQ(selected(), -1);
    arktest.assertEQ(selected(options), -1);
    options.strategy = Strategy.FOLLOW;
    arktest.assertEQ(selected(options), 1);
    arktest.assertEQ(selectedUnion(), -1);
    arktest.assertEQ(selectedUnion(options), 0);
    options.selection = Strategy.FOLLOW;
    arktest.assertEQ(selectedUnion(options), 1);
    options.selection = 7;
    arktest.assertEQ(selectedUnion(options), 7);
}
